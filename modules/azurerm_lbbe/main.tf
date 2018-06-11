resource "azurerm_lb" "lb" {
  name                = "${var.azurerm_lb_name}LB"
  location            = "${var.azurerm_resource_group_location}"
  resource_group_name = "${var.azurerm_resource_group_name}"
  frontend_ip_configuration {
    name                          = "${var.azurerm_lb_name}FEIP"
    subnet_id                     = "${var.azurerm_subnet_id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "BEPool" {
  resource_group_name = "${var.azurerm_resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
  name                = "${var.azurerm_lb_name}BEAddressPool"
}
