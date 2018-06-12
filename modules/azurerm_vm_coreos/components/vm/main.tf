
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.azurerm_virtual_machine_name}"
  location              = "${var.azurerm_resource_group_location}"
  resource_group_name   = "${var.azurerm_resource_group_name}"
  network_interface_ids = ["${var.azurerm_network_interface_id}"]
  vm_size               = "${var.azurerm_virtual_machine_vm_size}"
  availability_set_id   = "${var.azurerm_availability_set_id}"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true
  storage_image_reference {
    publisher = "${var.azurerm_virtual_machine_image_publisher}"
    offer     = "${var.azurerm_virtual_machine_image_offer}"
    sku       = "${var.azurerm_virtual_machine_image_sku}"
    version   = "${var.azurerm_virtual_machine_image_version}"
  }
  storage_os_disk {
    name              = "${var.azurerm_virtual_machine_name}osdisk01"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_data_disk {
    name            = "${var.azurerm_managed_disk_name}"
    managed_disk_id = "${var.azurerm_managed_disk_id}"
    create_option   = "Attach"
    lun             = 1
    disk_size_gb    = "${var.azurerm_managed_disk_size}"
  }
  os_profile {
    computer_name  = "${var.azurerm_virtual_machine_name}"
    admin_username = "testadmin"
    admin_password = "Password1234!"
    custom_data    = "${var.azurerm_custom_data}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags {
    environment = "Production"
  }
}
