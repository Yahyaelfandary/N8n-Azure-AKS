variable "psql_server_SNet_id" {
  description = "The subnet ID for the PostgreSQL private endpoint"
  type        = string
  
}

variable "location" {
  description = "The location of the resource group"
  type        = string

}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  
}