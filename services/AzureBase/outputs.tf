output "AzureRGLocation" {
  value = "${azurerm_resource_group.network.location}"
}

output "AzureRGName" {
  value = "${azurerm_resource_group.network.name}"
}

output "AzureVNID" {
  value = "${azurerm_virtual_network.network.id}"
}

output "AzureVNAddress_Space" {
  value = "${azurerm_virtual_network.network.address_space}"
}

output "AzureVNName" {
  value = "${azurerm_virtual_network.network.name}"
}
