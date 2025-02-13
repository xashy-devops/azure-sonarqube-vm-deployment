# outputs.tf
output "resource_group_name" {
  value       = module.sonarqube.resource_group_name
  description = "The name of the resource group"
}

output "vm_name" {
  value       = module.sonarqube.vm_name
  description = "The name of the virtual machine"
}

output "vm_id" {
  value       = module.sonarqube.vm_id
  description = "The ID of the virtual machine"
}

output "public_ip_address" {
  value       = module.sonarqube.public_ip_address
  description = "The public IP address of the virtual machine"
}

output "sonarqube_url" {
  value       = module.sonarqube.sonarqube_url
  description = "The URL to access SonarQube"
}

output "ssh_command" {
  value       = module.sonarqube.ssh_command
  description = "Command to SSH into the virtual machine"
}
