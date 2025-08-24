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

variable "rg-n8n-aks-nsg_name" {
  description = "The name of the network security group"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)

}

variable "hub_jumpserver_subnet_name" {
  description = "The name of the jump server subnet"
  type        = string
}

variable "JumpServerPublicIP" {
  description = "The name of the Jump Server Public IP"
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes for the virtual network subnets"
  type        = list(string)

}

variable "source_address_dev" {
  description = "The source address for development"
  type        = string

}

variable "logic_rg-n8n-aks-vnet_name" {
  description = "The name of the virtual network for the logic module"
  type        = string
}

variable "logic_address_space" {
  description = "The address space for the logic module"
  type        = list(string)
}

variable "logic_address_prefixes" {
  description = "The address prefixes for the logic module subnets"
  type        = list(string)
}

variable "data_rg-n8n-aks-vnet_name" {
  description = "The name of the virtual network for the data module"
  type        = string

}

variable "data_address_space" {
  description = "The address space for the data module"
  type        = list(string)
}

variable "data_address_prefixes" {
  description = "The address prefixes for the data module subnets"
  type        = list(string)
}

variable "data_nsg_name" {
  description = "The name of the network security group for the data module"
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID for the Azure provider"
  type        = string  
  
}