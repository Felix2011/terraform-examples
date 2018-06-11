variable "azurerm_network_interface_ip_configuration_name" {}

variable "azurerm_subnet_id" {}

variable "azurerm_resource_group_name" {}

variable "azurerm_resource_group_location" {}

variable "azurerm_network_interface_name" {}

variable "azurerm_managed_disk_size" {}

variable "azurerm_managed_disk_name" {}

variable "azurerm_virtual_machine_name" {}

variable "azurerm_virtual_machine_image_publisher" {}

variable "azurerm_virtual_machine_image_offer" {}

variable "azurerm_virtual_machine_image_sku" {}

variable "azurerm_virtual_machine_image_version" {}

variable "azurerm_virtual_machine_vm_size" {}

variable "azurerm_availability_set_id" {}

variable "azurerm_load_balancer_backend_address_pools_ids" {
  type = "list"
}

variable "azurerm_custom_data" {}
