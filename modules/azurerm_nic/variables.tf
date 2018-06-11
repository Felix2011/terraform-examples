variable "azurerm_network_interface_ip_configuration_name" {}

variable "azurerm_subnet_id" {}

variable "azurerm_resource_group_name" {}

variable "azurerm_resource_group_location" {}

variable "azurerm_network_interface_name" {}

variable "azurerm_load_balancer_backend_address_pools_ids" {
  type = "list"
}
