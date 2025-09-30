resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = var.psql_db_name
  server_id = var.psql_server_id
  charset   = "UTF8"
  collation = "en_US.utf8"
}