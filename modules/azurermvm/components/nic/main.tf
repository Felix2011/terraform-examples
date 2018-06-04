resource "azurerm_network_interface" "nic" {
  name                = "${var.azurerm_network_interface_name}"
  location            = "${var.azurerm_resource_group_location}"
  resource_group_name = "${var.azurerm_resource_group_name}"
  ip_configuration {
    name                          = "${var.azurerm_network_interface_ip_configuration_name}"
    subnet_id                     = "${var.azurerm_subnet_id}"
    private_ip_address_allocation = "dynamic"
  }
}

output "nic_id" {
  value = "${azurerm_network_interface.nic.id}"
}
