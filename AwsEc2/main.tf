terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Use your default VPC so you don't have to define networking from scratch
data "aws_vpc" "default" {
  default = true
}

# Latest Ubuntu 22.04 LTS (Jammy) AMD64 from Canonical
data "aws_ami" "ubuntu_jammy" {
  owners      = ["099720109477"] # Canonical
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# One SG: allow SSH (22) and HTTP (80) from anywhere, egress all
resource "aws_security_group" "web_ssh" {
  name        = "ec2-web-ssh"
  description = "Allow SSH and HTTP from anywhere"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "All egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ec2-web-ssh-sg"
  }
}

# Create a Key Pair from your local public key file
resource "aws_key_pair" "local_key" {
  key_name   = "temporary_key"
  public_key = trimspace(file("${path.module}/azure_vm_rsa.pub"))
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu_jammy.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.web_ssh.id]
  associate_public_ip_address = true

  tags = {
    Name = "ubuntu-web"
  }
}

output "instance_id" { value = aws_instance.web.id }
output "public_ip" { value = aws_instance.web.public_ip }
output "public_dns" { value = aws_instance.web.public_dns }
