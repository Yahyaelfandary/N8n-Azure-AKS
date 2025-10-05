output "resource_group_name" {
  value = azurerm_resource_group.rg-n8n-aks.name
}


output "virtual_network_name" {
  value = azurerm_virtual_network.rg-n8n-aks.name
}

output "virtual_network_hub_id" {
  value = azurerm_virtual_network.rg-n8n-aks.id
}

output "address_prefixes" {
  value = azurerm_subnet.AzureFirewallSubnet.address_prefixes
  
}

output "jumpserver_nic_id" {
  value = azurerm_network_interface.JumpServerNIC.id
  
}

output "AzureFirewallSubnet_id" {
  value = azurerm_subnet.AzureFirewallSubnet.id
  
}