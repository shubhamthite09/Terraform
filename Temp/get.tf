terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "e7f7c12f-2fdd-4577-8491-58739148bbe1"
  tenant_id       = "48be7b78-141a-493d-90b0-5e2922a7b72b"
}

# ---- Canonical Ubuntu 22.04 LTS Gen2 in West India (Mumbai) ----
locals {
  location  = "westindia"  # programmatic name
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-gen2"
  version   = "latest"
  urn       = "${local.publisher}:${local.offer}:${local.sku}:${local.version}"
}

# If you just want to print a “name”, output the URN:
output "ubuntu_2204_image_urn" {
  value = local.urn
}