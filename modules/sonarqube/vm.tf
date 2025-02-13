# vm.tf

locals {
  custom_data = templatefile("${path.module}/scripts/setup.sh", {
    postgres_password  = var.postgres_password
    sonarqube_version = var.sonarqube_version
    postgres_version  = var.postgres_version
  })
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  tags = var.tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb        = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(local.custom_data)

}
