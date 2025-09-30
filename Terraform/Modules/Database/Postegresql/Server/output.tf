output "name" {
  value = azurerm_postgresql_flexible_server.PSQL.id
}

output "psql_server_id" {
  value       = azurerm_postgresql_flexible_server.PSQL.id
  description = "The ID of the PostgreSQL server"
  
}