module "config" {
  source         = "./data"
#  name           = "${var.name}"
  op_key         = "${var.op_key}"
}

output "httpd-ignition" {
  value = "${module.config.httpd-ignition}"
}

#      "guestinfo.coreos.config.data"              = "${base64encode(module.config.nessus-ignition)}"
