variable "resource_group_name" {
  description = "The name of the resource group in which to create the VM."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "Hub-FW-subnet_id" {
  description = "The ID of the subnet where the Azure Firewall will be deployed."
  type        = string
}