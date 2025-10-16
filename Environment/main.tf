module "resource_group" {
  source      = "../Module/azurerm_resource_group"
  rg_name     = "demo-rg"
  rg_location = "west europe"
}

module "virtual_network" {
  depends_on    = [module.resource_group]
  source        = "../Module/azurerm_virtual_network"
  vnet_name     = "demo-vnet"
  vnet_location = "west europe"
  rg_name       = "demo-rg"
}

module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../Module/azurerm_subnet"
  snet_name  = "demo-snet"
  rg_name    = "demo-rg"
  vnet_name  = "demo-vnet"
}

module "pip" {
  depends_on   = [module.resource_group]
  source       = "../Module/azurerm_public_ip"
  pip_name     = "demo-pip"
  rg_name      = "demo-rg"
  pip_location = "west europe"
}

module "virtual_machine" {
  depends_on   = [module.subnet, module.pip]
  source       = "../Module/azurerm_virtual_machine"
  nic_name     = "demo-nic"
  nic_location = "west europe"
  rg_name      = "demo-rg"
  vm_name      = "demo-vm"
  vm_location  = "west europe"
  nsg_name     = "demo-nsg"
  nsg_location = "west europe"
  snet_name    = "demo-snet"
  vnet_name    = "demo-vnet"
  pip_name     = "demo-pip"
  
}