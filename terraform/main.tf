resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # ❌ HIGH RISK — allows public containers
  allow_nested_items_to_be_public = true

  # ❌ HIGH RISK — open to internet
  public_network_access_enabled = true
}

resource "azurerm_storage_container" "container" {
  name                  = "public-data"
  storage_account_name  = azurerm_storage_account.storage.name

  # ❌ HIGH RISK — public read access
  container_access_type = "blob"
}

# test change to trigger AI review
