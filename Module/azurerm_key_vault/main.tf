resource "azurerm_key_vault" "azurerm_kv" {
  name                        = var.kv_name
  location                    = var.kv_location
  resource_group_name         = var.rg_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
    ]
  }
}
 
resource "azurerm_key_vault_secret" "azurerm_kvs1" {
  depends_on = [ azurerm_key_vault.azurerm_kv ]
  name         = "Admin-UserName"
  value        = "demo-admin"
  key_vault_id = azurerm_key_vault.azurerm_kv.id
}

resource "azurerm_key_vault_secret" "azurerm_kvs2" {
  depends_on = [ azurerm_key_vault.azurerm_kv ]
  name         = "Admin-Password"
  value        = "Demo-password01"
  key_vault_id = azurerm_key_vault.azurerm_kv.id
}