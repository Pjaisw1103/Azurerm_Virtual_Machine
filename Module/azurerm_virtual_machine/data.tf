data "azurerm_subnet" "snet" {
  name                 = var.snet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

data "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "kvs1" {
  name         = "Admin-UserName"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "kvs2" {
  name         = "Admin-Password"
  key_vault_id = data.azurerm_key_vault.kv.id
}

