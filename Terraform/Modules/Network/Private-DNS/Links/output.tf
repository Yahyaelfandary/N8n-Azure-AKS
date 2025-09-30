output "private_dns_zone_id" {
  value       = azurerm_private_dns_zone_virtual_network_link.Link.id
  description = "The ID of the private DNS zone link"
  
}