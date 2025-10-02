variable "resource_group_name" {
  description = "The name of the resource group in which to create the VM."
  type        = string
  
}

variable "location" {
  description = "The location where the VM will be created."
  type        = string

}

variable "admin_username" {
  description = "The admin username for the VM."
  type        = string

}

variable "admin_password" {
  description = "The admin password for the VM."
  type        = string

}

variable "network_interface_id" {
  description = "The ID of the network interface to attach to the VM."
  type        = string
  
}