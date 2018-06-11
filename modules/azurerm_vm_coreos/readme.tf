# Example use
#
#module "webvm01" {
#  source     = "../../modules/azurerm_vm_coreos"
#  azurerm_network_interface_ip_configuration_name = "webvm01nic01configuration"
#  azurerm_subnet_id                               = "${data.azurerm_subnet.web.id}"
#  azurerm_resource_group_name                     = "${data.azurerm_resource_group.network.name}"
#  azurerm_resource_group_location                 = "${data.azurerm_resource_group.network.location}"
#  azurerm_availability_set_id                     = "${azurerm_availability_set.webavs.id}"
#  azurerm_network_interface_name                  = "webvm01nic01"
#  azurerm_load_balancer_backend_address_pools_ids = ["${module.weblb.BEPool_id}"]
#  azurerm_managed_disk_size                       = "1023"
#  azurerm_managed_disk_name                       = "webvm01datadisk01"
#  azurerm_virtual_machine_name                    = "webvm01"
#  azurerm_virtual_machine_vm_size                 = "Standard_B1s"
#  azurerm_virtual_machine_image_publisher         = "CoreOS"
#  azurerm_virtual_machine_image_offer             = "CoreOS"
#  azurerm_virtual_machine_image_sku               = "Stable"
#  azurerm_virtual_machine_image_version           = "latest"
#}
