variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  
}

variable "location" {
  description = "The location of the resource group"
  type        = string

}

variable "delegated_subnet_id" {
  description = "The ID of the delegated subnet"
  type        = string

}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone"
  type        = string

}

variable "administrator_login" {
  description = "The administrator login for the PostgreSQL server"
  type        = string

}

variable "administrator_password" {
  description = "The administrator password for the PostgreSQL server"
  type        = string

}
variable "psql_server" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "psql_server_SNet_id" {
  description = "The subnet ID for the PostgreSQL private endpoint"
  type        = string
  
}