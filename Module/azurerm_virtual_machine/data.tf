data "azurerm_subnet" "snet" {
  name                 = var.snet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

data "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
}


