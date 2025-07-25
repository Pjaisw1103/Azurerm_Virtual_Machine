resource "azurerm_network_interface" "azurerm_nic" {
  name                = var.nic_name
  location            = var.nic_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pip.id
  }
}

resource "azurerm_network_security_group" "azurerm_nsg" {
  name                = var.nsg_name
  location            = var.nsg_location
  resource_group_name = var.rg_name

  security_rule {
  name                       = "Allow-SSH"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix    = "*"
  destination_address_prefix = "*"
 }

 security_rule {
  name                       = "Allow-HTTP"
  priority                   = 110
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
 }
}

resource "azurerm_network_interface_security_group_association" "azurerm_nisga" {
  network_interface_id      = azurerm_network_interface.azurerm_nic.id
  network_security_group_id = azurerm_network_security_group.azurerm_nsg.id
}

resource "azurerm_linux_virtual_machine" "azurerm_vm" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.vm_location
  size                = "Standard_F2"
  admin_username      = data.azurerm_key_vault_secret.kvs1.value
  admin_password      = data.azurerm_key_vault_secret.kvs2.value
  network_interface_ids = [
    azurerm_network_interface.azurerm_nic.id,
  ]
  disable_password_authentication = "false"

    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

   custom_data = base64encode(<<EOF
    #cloud-config
    package_update: true
    package_upgrade: true
    packages:
      - nginx
    runcmd:
      - systemctl start nginx
      - systemctl enable nginx
    EOF
  )
}


