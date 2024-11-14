terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_primary" {
  name     = "rg-fhgr-gruppe3"
  location = "switzerlandnorth"
  tags = {
    environment = var.environment
    owner       = var.owner
  }
}

resource "azurerm_storage_account" "stac_primary" {
  name                     = "stacfhgrgruppe3"
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

resource "azurerm_resource_group" "rg_secondary" {
  name     = "rg-fhgr-gruppe3-secondary"
  location = "switzerlandnorth"
  tags = {
    environment = var.environment
    owner       = var.owner
  }
}

resource "azurerm_storage_account" "stac_secondary" {
  name                     = "stacsecondaryfhgrgruppe3"
  resource_group_name      = azurerm_resource_group.rg_secondary.name
  location                 = azurerm_resource_group.rg_secondary.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.environment
    owner       = var.owner
  }
}

resource "azurerm_storage_container" "container_secondary" {
  name                  = "secondary-container"
  storage_account_name  = azurerm_storage_account.stac_secondary.name
  container_access_type = "private"
}
