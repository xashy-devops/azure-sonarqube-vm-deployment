# variables.tf

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region location"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

# Network variables
variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for VNet"
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "subnet_address_prefix" {
  type        = string
  description = "Address prefix for subnet"
  default     = "10.0.1.0/24"
}

# VM variables
variable "vm_name" {
  type        = string
  description = "Name of the Virtual Machine"
}

variable "vm_size" {
  type        = string
  description = "Size of the Virtual Machine"
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  type        = string
  description = "Admin username for VM"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM access"
}

# OS variables
variable "os_disk_type" {
  type        = string
  description = "OS disk type"
  default     = "Premium_LRS"
}

variable "os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB"
  default     = 64
}

# SonarQube variables
variable "sonarqube_version" {
  type        = string
  description = "SonarQube version to install"
  default     = "9.9-community"
}

variable "postgres_version" {
  type        = string
  description = "PostgreSQL version to install"
  default     = "13"
}

variable "postgres_password" {
  type        = string
  description = "PostgreSQL password"
  sensitive   = true
}

# Networking Security variables
variable "allowed_ip_ranges" {
  type        = list(string)
  description = "List of IP ranges to allow access to SonarQube"
  default     = ["0.0.0.0/0"]
}
