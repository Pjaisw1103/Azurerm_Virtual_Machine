variable "vm_list" {
  description = "A map of virtual machine configurations. The key is a unique identifier for each VM."
  type = map(object({
    # Virtual Machine Arguments
    vm_name                         = string
    vm_location                     = string
    rg_name                         = string
    vm_size                         = optional(string, "Standard_DS1_v2")
    admin_username                  = optional(string, "azureuser")
    admin_password                  = optional(string)
    disable_password_authentication = optional(bool, false)
    custom_data                     = optional(string)
    tags                            = optional(map(string), {})

    # OS Disk Arguments
    os_disk_caching              = optional(string, "ReadWrite")
    os_disk_storage_account_type = optional(string, "Standard_LRS")
    os_disk_size_gb              = optional(number)

    # Source Image Reference
    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }), {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    })

    # Network Interface Arguments
    nic_name = string
    ip_configuration_name = optional(string, "internal")
    private_ip_address_allocation = optional(string, "Dynamic")
    private_ip_address = optional(string)

    # Subnet & VNet (for Data Source)
    snet_name    = string
    vnet_name    = string
    vnet_rg_name = optional(string) # Defaults to rg_name if not provided

    # Public IP (Optional)
    pip_name    = optional(string)
    pip_rg_name = optional(string) # Defaults to rg_name if not provided

    # Network Security Group (Optional)
    nsg_name = optional(string)
    security_rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })), [])
  }))
}
