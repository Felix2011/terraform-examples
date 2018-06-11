resource "azurerm_public_ip" "publicip" {
  name                         = "${var.azurerm_lb_name}LBPublicIP"
  location                     = "${var.azurerm_resource_group_location}"
  resource_group_name          = "${var.azurerm_resource_group_name}"
  public_ip_address_allocation = "static"
}

resource "azurerm_lb" "lb" {
  name                = "${var.azurerm_lb_name}LB"
  location            = "${var.azurerm_resource_group_location}"
  resource_group_name = "${var.azurerm_resource_group_name}"
  frontend_ip_configuration {
    name                 = "${var.azurerm_lb_name}FEIP"
    public_ip_address_id = "${azurerm_public_ip.publicip.id}"
  }
}

resource "azurerm_lb_backend_address_pool" "BEPool" {
  resource_group_name = "${var.azurerm_resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
  name                = "${var.azurerm_lb_name}BEAddressPool"
}
