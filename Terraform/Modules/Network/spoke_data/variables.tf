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
  type        = list(string)
}

variable "address_prefixes" {
  description = "The address prefixes for the virtual network subnets"
  type        = list(string)

}

variable "rg-n8n-aks-nsg_name" {
  description = "The name of the network security group"
  type        = string
  default     = "rg-n8n-aks-nsg"
}

variable "source_address_prefix_logic" {
  description = "The address prefix for the logic subnet"
  type        = string
}