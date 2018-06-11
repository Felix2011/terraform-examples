# Example use
#
#module "nic" {
#  source  = "../azurerm_nic"
#  azurerm_network_interface_ip_configuration_name = "${var.azurerm_network_interface_ip_configuration_name}"
#  azurerm_subnet_id                               = "${var.azurerm_subnet_id}"
#  azurerm_resource_group_name                     = "${var.azurerm_resource_group_name}"
#  azurerm_resource_group_location                 = "${var.azurerm_resource_group_location}"
#  azurerm_network_interface_name                  = "${var.azurerm_network_interface_name}"
#  azurerm_load_balancer_backend_address_pools_ids = ["${var.azurerm_load_balancer_backend_address_pools_ids}"]
#}
