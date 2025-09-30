resource "azurerm_resource_group" "rg-n8n-aks" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "rg-n8n-aks" {
  name                = var.rg-n8n-aks-vnet_name
  location            = azurerm_resource_group.rg-n8n-aks.location
  resource_group_name = azurerm_resource_group.rg-n8n-aks.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "rg-n8n-aks" {
    name                 = var.subnet_name
    address_prefixes     = var.address_prefixes
    resource_group_name  = azurerm_resource_group.rg-n8n-aks.name
    virtual_network_name = azurerm_virtual_network.rg-n8n-aks.name
  }