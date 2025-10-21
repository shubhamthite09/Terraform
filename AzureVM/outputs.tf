output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "ssh_private_key_file" {
  value       = local_file.private_key_pem.filename
  description = "Private key saved locally (keep it secure!)"
  sensitive   = true
}

output "ssh_command" {
  value       = "ssh -i ${local_file.private_key_pem.filename} ${var.admin_username}@${azurerm_public_ip.pip.ip_address}"
  description = "Convenient SSH command"
}
