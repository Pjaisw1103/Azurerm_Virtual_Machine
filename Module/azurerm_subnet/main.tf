resource "azurerm_subnet" "azurerm_snet" {
  name                 = var.snet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes       = ["10.0.1.0/24"]
}
