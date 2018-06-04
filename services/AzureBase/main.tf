terraform {
  backend "azurerm" {
    storage_account_name = "denheenj"
    container_name       = "terraform-storage"
    key                  = "prod_west_eu1_base.terraform.tfstate"
  }
}

provider "azurerm" {
  subscription_id = "${var.AzureSubID}"
  tenant_id = "${var.AzureTennantID}"
}

resource "azurerm_resource_group" "network" {
  name     = "prod_west_eu1"
  location = "West Europe"
}

resource "azurerm_virtual_network" "network" {
  name                = "production-network"
  address_space       = ["10.10.0.0/16"]
  location            = "${azurerm_resource_group.network.location}"
  resource_group_name = "${azurerm_resource_group.network.name}"

  subnet {
    name           = "Web"
    address_prefix = "10.10.1.0/24"
  }

  subnet {
    name           = "App"
    address_prefix = "10.10.2.0/24"
  }

  subnet {
    name           = "Data"
    address_prefix = "10.10.3.0/24"
  }
}
