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

resource "azurerm_subnet" "subnet" {
  name                 = "DBSubnet"
  address_prefixes     = var.address_prefixes
  resource_group_name  = azurerm_resource_group.rg-n8n-aks.name
  virtual_network_name = azurerm_virtual_network.rg-n8n-aks.name
  # service_endpoints    = ["Microsoft.DBforPostgreSQL/flexibleServers"]

  delegation {
    name = "dbDelegation"

    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_security_group" "rg-n8n-aks-nsg" {
  name                = var.rg-n8n-aks-nsg_name
  location            = azurerm_resource_group.rg-n8n-aks.location
  resource_group_name = azurerm_resource_group.rg-n8n-aks.name

  security_rule {
    name                       = "Allow-Hub-to-Logic-PostgreSQL"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = var.source_address_prefix_logic
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  subnet_id      = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.rg-n8n-aks-nsg.id
}
