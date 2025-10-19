variable "n8n-aks-name" {
  description = "name of the AKS cluster"
}

variable "dns-prefix" {
  description = "DNS prefix for the AKS cluster"
}

variable "node-count" {
  description = "Number of nodes in the default node pool"
  type        = number
}

variable "vm-size" {
  description = "Size of the virtual machines in the default node pool"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the AKS cluster"
  type        = string
}
variable "resource_group_location" {
  description = "The location of the resource group in which to create the AKS cluster"
  type        = string
}

variable "vnet_subnet_id" {
  description = "The id of the subnet which aks cluster be deployed into"
  type        = string
}

variable "service_cidr" {
  description = "the actual address space or ip range used internally in aks for the cluster ip"
  type        = string
}

variable "dns_service_ip" {
  description = "The internal dns service ip address for the aks cluster"
  type        = string
}

variable "docker_bridge_cidr" {
  description = "The internal docker bridge cidr for the aks cluster"
  type        = string
}