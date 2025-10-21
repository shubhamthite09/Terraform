variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "ap-south-1" # Mumbai — change if needed
}

variable "key_name" {
  description = "Existing EC2 key pair name to enable SSH access"
  type        = string
  default     = "azure_vm_rsa.pub" # Change to your key pair name
}
