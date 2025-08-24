resource "azurerm_virtual_network_peering" "Peering" {
    name                      = var.virtual_network_name
    resource_group_name       = var.resource_group_name
    virtual_network_name      = var.rg-n8n-aks-vnet_name
    remote_virtual_network_id = var.remote_virtual_network_id
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false

}