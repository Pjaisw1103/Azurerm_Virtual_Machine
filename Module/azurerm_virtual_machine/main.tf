resource "azurerm_network_interface" "azurerm_nic" {
  name                = var.nic_name
  location            = coalesce(var.nic_location, var.vm_location)
  resource_group_name = var.rg_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pip.id
  }
}

resource "azurerm_network_security_group" "azurerm_nsg" {
  name                = var.nsg_name
  location            = coalesce(var.nsg_location, var.vm_location)
  resource_group_name = var.rg_name
  tags                = var.tags

  dynamic "security_rule" {
    for_each = var.security_rules
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
  network_interface_id      = azurerm_network_interface.azurerm_nic.id
  network_security_group_id = azurerm_network_security_group.azurerm_nsg.id
}

resource "azurerm_linux_virtual_machine" "azurerm_vm" {
  name                            = var.vm_name
  resource_group_name             = var.rg_name
  location                        = var.vm_location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.disable_password_authentication
  network_interface_ids           = [azurerm_network_interface.azurerm_nic.id]
  custom_data                     = var.custom_data != null ? base64encode(var.custom_data) : null
  tags                            = var.tags

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }
}
