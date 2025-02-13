# outputs.tf

output "resource_group_name" {
  value       = var.resource_group_name
  description = "The name of the resource group"
}

output "vm_name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "The name of the virtual machine"
}

output "vm_id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "The ID of the virtual machine"
}

output "public_ip_address" {
  value       = azurerm_public_ip.pip.ip_address
  description = "The public IP address of the virtual machine"
}

output "sonarqube_url" {
  value       = "http://${azurerm_public_ip.pip.ip_address}:9000"
  description = "The URL to access SonarQube"
}

output "ssh_command" {
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.pip.ip_address}"
  description = "Command to SSH into the virtual machine"
}

output "virtual_network_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "The ID of the virtual network"
}

output "subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "The ID of the subnet"
}
