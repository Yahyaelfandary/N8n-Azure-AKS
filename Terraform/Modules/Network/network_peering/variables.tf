variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "rg-n8n-aks-vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "remote_virtual_network_id" {
  description = "The ID of the remote virtual network"
  type        = string
  
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}