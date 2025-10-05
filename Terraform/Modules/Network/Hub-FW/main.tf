resource "azurerm_public_ip" "Hub-FW-PIP" {
  name                = "Hub-FW-PIP"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "Hub-FW" {
  name                = "Hub-FW"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.Hub-FW-Policy.id
  depends_on          = [ azurerm_public_ip.Hub-FW-PIP ]

  ip_configuration {
    name                 = "AzureFirewallSubnet"
    subnet_id            = var.Hub-FW-subnet_id
    public_ip_address_id = azurerm_public_ip.Hub-FW-PIP.id
  }
}

resource "azurerm_firewall_policy" "Hub-FW-Policy" {
  name                = "Hub-FW-Policy"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}