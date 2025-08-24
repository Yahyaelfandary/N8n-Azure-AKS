variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "UK South"
}

variable "rg-n8n-aks-nsg_name" {
  description = "The name of the network security group"
  type        = string
  default     = "rg-n8n-aks-nsg"
  
}

variable "rg-n8n-aks-vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "rg-n8n-aks-network"
  
}

variable "address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/24"]

}

variable "source_address_dev" {
  description = "The source address for development"
  type        = string
  
}

variable "address_prefixes" {
  description = "The address prefixes for the virtual network subnets"
  type        = list(string)
  default     = ["10.0.0.0/27", "10.0.0.32/28"]
}