resource "azurerm_private_dns_zone" "rg_n8n_p_dns" {
  name                = var.p_dns_zone_name
  resource_group_name = var.resource_group_name
}