resource "azurerm_resource_group" "rg-n8n-aks" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_network_security_group" "rg-n8n-aks-nsg" {
  name                = var.rg-n8n-aks-nsg_name
  location            = azurerm_resource_group.rg-n8n-aks.location
  resource_group_name = azurerm_resource_group.rg-n8n-aks.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.source_address_dev
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.source_address_dev
    destination_address_prefix = "*"
  }
}

resource "azurerm_virtual_network" "rg-n8n-aks" {
  name                = var.rg-n8n-aks-vnet_name
  location            = azurerm_resource_group.rg-n8n-aks.location
  resource_group_name = azurerm_resource_group.rg-n8n-aks.name
  address_space       = var.address_space

  subnet {
    name             = "AzurefirewallSubnet"
    address_prefixes = [var.address_prefixes[0]]
  }

  subnet {
    name             = "JumpServerSubnet"
    address_prefixes = [var.address_prefixes[1]]
    security_group   = azurerm_network_security_group.rg-n8n-aks-nsg.id
  }

  tags = {
    environment = "Production"
  }
}