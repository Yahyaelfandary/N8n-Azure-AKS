output "resource_group_name" {
  value = azurerm_resource_group.rg-n8n-aks.name
}


output "virtual_network_name" {
  value = azurerm_virtual_network.rg-n8n-aks.name
}

output "virtual_network_hub_id" {
  value = azurerm_virtual_network.rg-n8n-aks.id
}