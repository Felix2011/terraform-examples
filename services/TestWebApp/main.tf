terraform {
  backend "azurerm" {
    storage_account_name = "denheenj"
    container_name       = "terraform-storage"
    key                  = "prod_west_eu1_testwebapp.terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = "${var.AzureSubID}"
  tenant_id = "${var.AzureTennantID}"
}

data "terraform_remote_state" "AzureBase" {
  backend = "azurerm"
  config {
    storage_account_name = "denheenj"
    container_name       = "terraform-storage"
    key                  = "prod_west_eu1_base.terraform.tfstate"
  }
}

data "azurerm_resource_group" "network" {
  name = "${data.terraform_remote_state.AzureBase.AzureRGName}"
}

data "azurerm_virtual_network" "network" {
  name                 = "${data.terraform_remote_state.AzureBase.AzureVNName}"
  resource_group_name  = "${data.azurerm_resource_group.network.name}"
}

data "azurerm_subnet" "web" {
  name                 = "${data.azurerm_virtual_network.network.subnets[0]}"
  virtual_network_name = "${data.azurerm_virtual_network.network.name}"
  resource_group_name  = "${data.azurerm_resource_group.network.name}"
}

data "azurerm_subnet" "app" {
  name                 = "${data.azurerm_virtual_network.network.subnets[2]}"
  virtual_network_name = "${data.azurerm_virtual_network.network.name}"
  resource_group_name  = "${data.azurerm_resource_group.network.name}"
}

data "azurerm_subnet" "data" {
  name                 = "${data.azurerm_virtual_network.network.subnets[1]}"
  virtual_network_name = "${data.azurerm_virtual_network.network.name}"
  resource_group_name  = "${data.azurerm_resource_group.network.name}"
}

resource "azurerm_availability_set" "webavs" {
  name                = "webavs"
  location            = "${data.azurerm_resource_group.network.location}"
  resource_group_name = "${data.azurerm_resource_group.network.name}"
  managed = true
  tags {
    environment = "Production"
  }
}

resource "azurerm_availability_set" "appavs" {
  name                = "appavs"
  location            = "${data.azurerm_resource_group.network.location}"
  resource_group_name = "${data.azurerm_resource_group.network.name}"
  managed = true
  tags {
    environment = "Production"
  }
}

resource "azurerm_public_ip" "webpublicip" {
  name                         = "WebLBPublicIP"
  location                     = "${data.azurerm_resource_group.network.location}"
  resource_group_name          = "${data.azurerm_resource_group.network.name}"
  public_ip_address_allocation = "static"
}

resource "azurerm_lb" "weblb" {
  name                = "WebLB"
  location            = "${data.azurerm_resource_group.network.location}"
  resource_group_name = "${data.azurerm_resource_group.network.name}"
  frontend_ip_configuration {
    name                 = "WebFEPublicIP"
    public_ip_address_id = "${azurerm_public_ip.webpublicip.id}"
  }
}

resource "azurerm_lb_backend_address_pool" "WebBEPool" {
  resource_group_name = "${data.azurerm_resource_group.network.name}"
  loadbalancer_id     = "${azurerm_lb.weblb.id}"
  name                = "WebBEAddressPool"
}

resource "azurerm_lb" "applb" {
  name                = "AppLB"
  location            = "${data.azurerm_resource_group.network.location}"
  resource_group_name = "${data.azurerm_resource_group.network.name}"
  frontend_ip_configuration {
    name                          = "AppFEPublicIP"
    subnet_id                     = "${data.azurerm_subnet.app.id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "AppBEPool" {
  resource_group_name = "${data.azurerm_resource_group.network.name}"
  loadbalancer_id     = "${azurerm_lb.applb.id}"
  name                = "AppBEAddressPool"
}

module "webvm01" {
  source     = "../../modules/azurermvm"
  azurerm_network_interface_ip_configuration_name = "webvm01nic01configuration"
  azurerm_subnet_id                               = "${data.azurerm_subnet.web.id}"
  azurerm_resource_group_name                     = "${data.azurerm_resource_group.network.name}"
  azurerm_resource_group_location                 = "${data.azurerm_resource_group.network.location}"
  azurerm_availability_set_id                     = "${azurerm_availability_set.webavs.id}"
  azurerm_network_interface_name                  = "webvm01nic01"
  azurerm_load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.WebBEPool.id}"]
  azurerm_managed_disk_size                       = "1023"
  azurerm_managed_disk_name                       = "webvm01datadisk01"
  azurerm_virtual_machine_name                    = "webvm01"
  azurerm_virtual_machine_vm_size                 = "Standard_B1s"
  azurerm_virtual_machine_image_publisher         = "CoreOS"
  azurerm_virtual_machine_image_offer             = "CoreOS"
  azurerm_virtual_machine_image_sku               = "Stable"
  azurerm_virtual_machine_image_version           = "latest"
}

module "webvm02" {
  source     = "../../modules/azurermvm"
  azurerm_network_interface_ip_configuration_name = "webvm02nic01configuration"
  azurerm_subnet_id                               = "${data.azurerm_subnet.web.id}"
  azurerm_resource_group_name                     = "${data.azurerm_resource_group.network.name}"
  azurerm_resource_group_location                 = "${data.azurerm_resource_group.network.location}"
  azurerm_availability_set_id                     = "${azurerm_availability_set.webavs.id}"
  azurerm_network_interface_name                  = "webvm02nic01"
  azurerm_load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.WebBEPool.id}"]
  azurerm_managed_disk_size                       = "1023"
  azurerm_managed_disk_name                       = "webvm02datadisk01"
  azurerm_virtual_machine_name                    = "webvm02"
  azurerm_virtual_machine_vm_size                 = "Standard_B1s"
  azurerm_virtual_machine_image_publisher         = "CoreOS"
  azurerm_virtual_machine_image_offer             = "CoreOS"
  azurerm_virtual_machine_image_sku               = "Stable"
  azurerm_virtual_machine_image_version           = "latest"
}

module "appvm01" {
  source     = "../../modules/azurermvm"
  azurerm_network_interface_ip_configuration_name = "vm01nic01configuration"
  azurerm_subnet_id                               = "${data.azurerm_subnet.app.id}"
  azurerm_resource_group_name                     = "${data.azurerm_resource_group.network.name}"
  azurerm_resource_group_location                 = "${data.azurerm_resource_group.network.location}"
  azurerm_availability_set_id                     = "${azurerm_availability_set.appavs.id}"
  azurerm_network_interface_name                  = "appvm01nic01"
  azurerm_load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.AppBEPool.id}"]
  azurerm_managed_disk_size                       = "1023"
  azurerm_managed_disk_name                       = "appvm01datadisk01"
  azurerm_virtual_machine_name                    = "appvm01"
  azurerm_virtual_machine_vm_size                 = "Standard_B1s"
  azurerm_virtual_machine_image_publisher         = "CoreOS"
  azurerm_virtual_machine_image_offer             = "CoreOS"
  azurerm_virtual_machine_image_sku               = "Stable"
  azurerm_virtual_machine_image_version           = "latest"
}
