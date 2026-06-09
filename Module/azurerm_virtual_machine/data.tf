data "azurerm_subnet" "snet" {
  for_each             = var.vm_list
  name                 = each.value.snet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = coalesce(each.value.vnet_rg_name, each.value.rg_name)
}

data "azurerm_public_ip" "pip" {
  for_each            = { for k, v in var.vm_list : k => v if v.pip_name != null }
  name                = each.value.pip_name
  resource_group_name = coalesce(each.value.pip_rg_name, each.value.rg_name)
}
