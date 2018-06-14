output "BEPool_id" {
  value = "${azurerm_lb_backend_address_pool.BEPool.id}"
}

output "public_ip" {
  value = "${azurerm_public_ip.publicip.ip_address}"
}
