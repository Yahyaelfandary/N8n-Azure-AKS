resource "azurerm_private_endpoint" "pe" {
  name                = "pe-postgres"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.psql_server_SNet_id

  private_service_connection {
    name                           = "psc-postgres"
    private_connection_resource_id = data.azurerm_postgresql_flexible_server.PSQL.id
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdnsz-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.dns.id]
  }
}