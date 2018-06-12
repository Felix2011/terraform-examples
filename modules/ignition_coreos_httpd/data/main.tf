data "ignition_user" "core" {
    name                = "core"
    ssh_authorized_keys = [
      "${var.op_key}",
      ]
}

#############
#files start#
#############

data "template_file" "index_html" {
  template = "${file("${path.module}/index_html.tpl")}"
  vars {
  }
}

data "ignition_file" "index_html" {
    filesystem = "root"
    path       = "/var/docker/htdocs/index.html"
    mode       = "420"
    content {
        content = "${data.template_file.index_html.rendered}"
    }
}

###############
#systemd start#
###############

data "template_file" "httpd" {
  template = "${file("${path.module}/httpd.tpl")}"
  vars {
  }
}
data "ignition_systemd_unit" "httpd" {
  name = "httpd.service"
  content = "${data.template_file.httpd.rendered}"
}

data "ignition_config" "httpd" {
  users = [
    "${data.ignition_user.core.id}",
  ]
  files = [
    "${data.ignition_file.index_html.id}",
  ]
  systemd = [
    "${data.ignition_systemd_unit.httpd.id}",
  ]
}

output "httpd-ignition" {
  value = "${data.ignition_config.httpd.rendered}"
}
