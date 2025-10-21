variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
  default = "e7f7c12f-2fdd-4577-8491-58739148bbe1"
}

variable "project" {
  type        = string
  default     = "demo-ec2-on-azure"
  description = "Name prefix for resources"
}

variable "location" {
  type    = string
  default = "South India" # Mumbai
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "vm_size" {
  type    = string
  # was "Standard_B1s"
  default     = "Standard_B1ms"
  description = "VM size (pick one available in your region)"
}

variable "ssh_allowed_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/32"] # Replace with your public IP/CIDR
  description = "CIDRs allowed to SSH"
}

# If you want to use your own public key instead of generating:
variable "ssh_public_key_path" {
  type        = string
  default     = "./azure_vm_rsa.pub"
  description = "Path to an existing SSH public key"
}
