terraform {
  backend "azurerm" {}
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_primary" {
  name     = "rg-terraform-practice-primary-silvan"
  location = "switzerlandnorth"
  tags = {
    environment = var.environment
    owner       = var.owner
  }
}

resource "azurerm_storage_account" "stac_primary" {
  name                     = "stacprimarysilvan123"
  resource_group_name      = azurerm_resource_group.rg_primary.name
  location                 = azurerm_resource_group.rg_primary.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.environment
    owner       = var.owner
  }
}

resource "azurerm_storage_container" "container_primary" {
  name                  = "primary-container"
  storage_account_name  = azurerm_storage_account.stac_primary.name
  container_access_type = "private"
}
