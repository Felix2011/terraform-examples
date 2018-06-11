# Example use
#
#module "weblb" {
#  source     = "../../modules/azurerm_lbfe"
#  azurerm_resource_group_name     = "${data.azurerm_resource_group.network.name}"
#  azurerm_resource_group_location = "${data.azurerm_resource_group.network.location}"
#  azurerm_lb_name                 = "web"
#  azurerm_lb_fe_port              = "80"
#  azurerm_lb_be_port              = "80"
#}
