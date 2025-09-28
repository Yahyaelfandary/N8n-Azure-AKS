output "private_dns_zone_name" {
  value       = azurerm_private_dns_zone.rg_n8n_p_dns.name
  description = "The name of the private DNS zone"
}
