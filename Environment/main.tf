module "resource_group" {
  source      = "../Module/azurerm_resource_group"
  rg_name     = var.rg_name
  rg_location = var.rg_location
}

module "virtual_network" {
  depends_on    = [module.resource_group]
  source        = "../Module/azurerm_virtual_network"
  vnet_name     = var.vnet_name
  vnet_location = var.vnet_location
  rg_name       = var.rg_name
}

module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../Module/azurerm_subnet"
  snet_name  = var.snet_name
  rg_name    = var.rg_name
  vnet_name  = var.vnet_name
}

module "pip" {
  depends_on   = [module.resource_group]
  source       = "../Module/azurerm_public_ip"
  pip_name     = var.pip_name
  rg_name      = var.rg_name
  pip_location = var.pip_location
}

module "virtual_machine" {
  depends_on   = [module.subnet, module.pip]
  source       = "../Module/azurerm_virtual_machine"
  
  rg_name      = var.rg_name
  vm_name      = var.vm_name
  vm_location  = var.vm_location
  
  nic_name     = var.nic_name
  nsg_name     = var.nsg_name
  
  admin_username = var.admin_username
  admin_password = var.admin_password
  
  snet_name    = var.snet_name
  vnet_name    = var.vnet_name
  pip_name     = var.pip_name
  
  tags = var.tags
}
