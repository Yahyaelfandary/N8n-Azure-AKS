provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "hub" {
  source               = "../../Modules/hub-logic"
  resource_group_name  = var.resource_group_name
  location             = var.location
  rg-n8n-aks-nsg_name  = var.rg-n8n-aks-nsg_name
  rg-n8n-aks-vnet_name = var.rg-n8n-aks-vnet_name
  address_space        = var.address_space
  source_address_dev   = var.source_address_dev
  address_prefixes     = var.address_prefixes
}

module "logic" {
  source               = "../../Modules/spoke_logic"
  resource_group_name  = var.resource_group_name
  location             = var.location
  rg-n8n-aks-vnet_name = var.logic_rg-n8n-aks-vnet_name
  address_space        = var.logic_address_space
  address_prefixes     = var.logicaddress_prefixes
}

module "data" {
  source               = "../../Modules/spoke_data"
  resource_group_name  = var.resource_group_name
  location             = var.location
  rg-n8n-aks-vnet_name = var.data_rg-n8n-aks-vnet_name
  address_space        = var.data_address_space
  address_prefixes     = var.data_address_prefixes
}