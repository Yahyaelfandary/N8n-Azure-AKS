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

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "azurefirewall" {
  name                 = "AzurefirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg-n8n-aks.name
  virtual_network_name = azurerm_virtual_network.rg-n8n-aks.name
  address_prefixes     = [var.address_prefixes[0]]
}

resource "azurerm_subnet" "jumpserver" {
  name                 = var.jumpserver_subnet_name
  resource_group_name  = azurerm_resource_group.rg-n8n-aks.name
  virtual_network_name = azurerm_virtual_network.rg-n8n-aks.name
  address_prefixes     = [var.address_prefixes[1]]
}

resource "azurerm_subnet_network_security_group_association" "jumpserver_nsg_assoc" {
  subnet_id                 = azurerm_subnet.jumpserver.id
  network_security_group_id = azurerm_network_security_group.rg-n8n-aks-nsg.id
}

resource "azurerm_public_ip" "JumpServerPublicIP" {
  name                = var.JumpServerPublicIP
  resource_group_name = azurerm_resource_group.rg-n8n-aks.name
  location            = azurerm_resource_group.rg-n8n-aks.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "JumpServerNIC" {
  name                = "JumpServerNIC"
  location            = azurerm_resource_group.rg-n8n-aks.location
  resource_group_name = azurerm_resource_group.rg-n8n-aks.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.jumpserver.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id           = azurerm_public_ip.JumpServerPublicIP.id
  }
}