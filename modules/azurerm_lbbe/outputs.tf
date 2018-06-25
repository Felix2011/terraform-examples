output "BEPool_id" {
  value = "${azurerm_lb_backend_address_pool.BEPool.id}"
}

output "private_ip" {
  value = "${azurerm_lb.lb.private_ip_address}"
}
