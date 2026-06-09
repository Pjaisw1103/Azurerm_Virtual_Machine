variable "rg_name" {}
variable "rg_location" {}
variable "vnet_name" {}
variable "vnet_location" {}
variable "snet_name" {}
variable "pip_name" {}
variable "pip_location" {}

# Generic VM List
variable "vm_list" {
  description = "A map of virtual machine configurations"
  type = any # Using any here to simplify, but the module enforces the type
}

variable "tags" {
  type = map(string)
}
