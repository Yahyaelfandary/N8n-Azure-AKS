output "resource_group_name" {
  value = azurerm_resource_group.rg-n8n-aks.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.rg-n8n-aks.name
}

output "virtual_network_logic_id" {
  value = azurerm_virtual_network.rg-n8n-aks.id
}

output "address_prefixes" {
  value = [for subnet in azurerm_virtual_network.rg-n8n-aks.subnet : subnet.address_prefixes if subnet.name == "AKSSubnet"][0]
}