resource "azurerm_postgresql_flexible_server" "PSQL" {
  name                          = var.psql_server
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "17"
  delegated_subnet_id           = var.delegated_subnet_id
  private_dns_zone_id           = var.private_dns_zone_id
  public_network_access_enabled = false
  administrator_login           = var.administrator_login
  administrator_password        = var.administrator_password
  zone                          = "1"


  storage_mb   = 32768
  storage_tier = "P4"

  sku_name   = "B_Standard_B1ms"

}