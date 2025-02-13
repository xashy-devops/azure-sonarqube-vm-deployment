(* # main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
} *)

locals {
  common_tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "SonarQube"
  })
}

module "sonarqube" {
  source = "./modules/sonarqube"  # Path to your child module

  # Resource naming and location
  resource_group_name = var.resource_group_name
  location           = var.location
  tags               = local.common_tags

  # Network configuration
  vnet_name             = "${var.prefix}-vnet"
  vnet_address_space    = var.vnet_address_space
  subnet_name           = "${var.prefix}-subnet"
  subnet_address_prefix = var.subnet_address_prefix
  allowed_ip_ranges     = var.allowed_ip_ranges

  # VM configuration
  vm_name         = "${var.prefix}-vm"
  vm_size         = var.vm_size
  admin_username  = var.admin_username
  ssh_public_key  = var.ssh_public_key
  os_disk_type    = var.os_disk_type
  os_disk_size_gb = var.os_disk_size_gb

  # SonarQube and PostgreSQL configuration
  sonarqube_version = var.sonarqube_version
  postgres_version  = var.postgres_version
  postgres_password = var.postgres_password
}
