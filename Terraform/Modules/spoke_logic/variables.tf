variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "rg-n8n-aks-vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  default     = ["10.0.1.0/24"]
}

variable "address_prefixes" {
  description = "The address prefixes for the virtual network subnets"
  type        = list(string)
  default     = ["10.0.1.0/25"]
}