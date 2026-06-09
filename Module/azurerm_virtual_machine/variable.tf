variable "rg_name" {
  description = "The name of the resource group in which to create the network interface and virtual machine."
  type        = string
}

variable "vm_location" {
  description = "The Azure region where the virtual machine should exist."
  type        = string
}

variable "nic_name" {
  description = "The name of the network interface."
  type        = string
}

variable "nic_location" {
  description = "The location of the network interface."
  type        = string
  default     = null
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "The SKU which should be used for this Virtual Machine, such as Standard_F2."
  type        = string
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine."
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "The password of the local administrator used for the Virtual Machine."
  type        = string
  sensitive   = true
}

variable "disable_password_authentication" {
  description = "Should Password Authentication be disabled on this Virtual Machine? Defaults to false."
  type        = bool
  default     = false
}

variable "os_disk_caching" {
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should be used for the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS."
  type        = string
  default     = "Standard_LRS"
}

variable "source_image_reference" {
  description = "Reference to the image used to create the virtual machine."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

variable "custom_data" {
  description = "The Base64-Encoded Custom Data which should be used for this Virtual Machine."
  type        = string
  default     = null
}

variable "nsg_name" {
  description = "The name of the network security group."
  type        = string
}

variable "nsg_location" {
  description = "The location of the network security group."
  type        = string
  default     = null
}

variable "security_rules" {
  description = "List of security rules to apply to the network security group."
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "Allow-SSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
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
  ]
}

variable "snet_name" {
  description = "The name of the subnet to which the NIC should be attached."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "pip_name" {
  description = "The name of the public IP address."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
