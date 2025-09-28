variable "link_name" {
  description = "The name of the private DNS zone link"
  type        = string
  
}

variable "virtual_network_id" {
  description = "The ID of the virtual network to link to the private DNS zone"
  type        = string
}

variable "registration_status" {
  description = "Whether auto-registration of virtual machine records is enabled"
  type        = bool
  default     = false
  
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone"
  type        = string
}