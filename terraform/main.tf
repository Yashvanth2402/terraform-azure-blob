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

  # ❌ HIGH RISK: Public access enabled
  allow_blob_public_access = true

  # ❌ HIGH RISK: No firewall / network rules
  public_network_access_enabled = true
}

resource "azurerm_storage_container" "container" {
  name                  = "public-data"
  storage_account_name  = azurerm_storage_account.storage.name

  # ❌ HIGH RISK: Public read access
  container_access_type = "blob"
}
