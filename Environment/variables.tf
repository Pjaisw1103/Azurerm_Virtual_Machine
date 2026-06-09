variable "rg_name" {}
variable "rg_location" {}
variable "vnet_name" {}
variable "vnet_location" {}
variable "snet_name" {}
variable "pip_name" {}
variable "pip_location" {}
variable "vm_name" {}
variable "vm_location" {}
variable "nic_name" {}
variable "nsg_name" {}
variable "admin_username" {}
variable "admin_password" {
  sensitive = true
}
variable "tags" {
  type = map(string)
}
