resource "azurerm_network_interface" "azurerm_nic" {
  for_each            = var.vm_list
  name                = each.value.nic_name
  location            = each.value.vm_location
  resource_group_name = each.value.rg_name
  tags                = each.value.tags

  ip_configuration {
    name                          = each.value.ip_configuration_name
    subnet_id                     = data.azurerm_subnet.snet[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    private_ip_address            = each.value.private_ip_address
    public_ip_address_id          = each.value.pip_name != null ? data.azurerm_public_ip.pip[each.key].id : null
  }
}

resource "azurerm_network_security_group" "azurerm_nsg" {
  for_each            = { for k, v in var.vm_list : k => v if v.nsg_name != null }
  name                = each.value.nsg_name
  location            = each.value.vm_location
  resource_group_name = each.value.rg_name
  tags                = each.value.tags

  dynamic "security_rule" {
    for_each = each.value.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_network_interface_security_group_association" "azurerm_nisga" {
  for_each                  = { for k, v in var.vm_list : k => v if v.nsg_name != null }
  network_interface_id      = azurerm_network_interface.azurerm_nic[each.key].id
  network_security_group_id = azurerm_network_security_group.azurerm_nsg[each.key].id
}

resource "azurerm_linux_virtual_machine" "azurerm_vm" {
  for_each                        = var.vm_list
  name                            = each.value.vm_name
  resource_group_name             = each.value.rg_name
  location                        = each.value.vm_location
  size                            = each.value.vm_size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids           = [azurerm_network_interface.azurerm_nic[each.key].id]
  custom_data                     = each.value.custom_data != null ? base64encode(each.value.custom_data) : null
  tags                            = each.value.tags

  os_disk {
    caching              = each.value.os_disk_caching
    storage_account_type = each.value.os_disk_storage_account_type
    disk_size_gb         = each.value.os_disk_size_gb
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}
