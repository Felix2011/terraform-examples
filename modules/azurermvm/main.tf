
module "nic" {
  source  = "./components/nic"
  azurerm_network_interface_ip_configuration_name = "${var.azurerm_network_interface_ip_configuration_name}"
  azurerm_subnet_id                               = "${var.azurerm_subnet_id}"
  azurerm_resource_group_name                     = "${var.azurerm_resource_group_name}"
  azurerm_resource_group_location                 = "${var.azurerm_resource_group_location}"
  azurerm_network_interface_name                  = "${var.azurerm_network_interface_name}"
}

module "datadisk" {
  source  = "./components/datadisk"
  azurerm_managed_disk_name       = "${var.azurerm_managed_disk_name}"
  azurerm_resource_group_name     = "${var.azurerm_resource_group_name}"
  azurerm_resource_group_location = "${var.azurerm_resource_group_location}"
  azurerm_managed_disk_size       = "${var.azurerm_managed_disk_size}"
}

module "vm" {
  source     = "./components/vm"
  azurerm_resource_group_name             = "${var.azurerm_resource_group_name}"
  azurerm_resource_group_location         = "${var.azurerm_resource_group_location}"
  azurerm_network_interface_id            = "${module.nic.nic_id}"
  azurerm_network_interface_name          = "${var.azurerm_network_interface_name}"
  azurerm_managed_disk_size               = "${var.azurerm_managed_disk_size}"
  azurerm_managed_disk_name               = "${var.azurerm_managed_disk_name}"
  azurerm_managed_disk_id                 = "${module.datadisk.datadisk_id}"
  azurerm_virtual_machine_name            = "${var.azurerm_virtual_machine_name}"
  azurerm_virtual_machine_image_publisher = "${var.azurerm_virtual_machine_image_publisher}"
  azurerm_virtual_machine_image_offer     = "${var.azurerm_virtual_machine_image_offer}"
  azurerm_virtual_machine_image_sku       = "${var.azurerm_virtual_machine_image_sku}"
  azurerm_virtual_machine_image_version   = "${var.azurerm_virtual_machine_image_version}"
  azurerm_virtual_machine_vm_size         = "${var.azurerm_virtual_machine_vm_size}"
}
