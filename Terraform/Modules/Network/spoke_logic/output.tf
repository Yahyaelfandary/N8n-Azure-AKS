output "resource_group_name" {
  value = azurerm_resource_group.rg-n8n-aks.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.rg-n8n-aks.name
}

output "virtual_network_logic_id" {
  value = azurerm_virtual_network.rg-n8n-aks.id
}

output "subnet_id" {
  value = azurerm_subnet.rg-n8n-aks.id
}
