resource "azurerm_managed_disk" "disk" {
  name                 = "${var.azurerm_managed_disk_name}"
  location             = "${var.azurerm_resource_group_location}"
  resource_group_name  = "${var.azurerm_resource_group_name}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "${var.azurerm_managed_disk_size}"
}

output "datadisk_id" {
  value = "${azurerm_managed_disk.disk.id}"
}
