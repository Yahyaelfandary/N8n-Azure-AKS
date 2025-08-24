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
  jumpserver_subnet_name = var.hub_jumpserver_subnet_name
  JumpServerPublicIP   = var.JumpServerPublicIP
}

module "logic" {
  source               = "../../Modules/spoke_logic"
  resource_group_name  = var.resource_group_name
  location             = var.location
  rg-n8n-aks-vnet_name = var.logic_rg-n8n-aks-vnet_name
  address_space        = var.logic_address_space
  address_prefixes     = var.logic_address_prefixes
}

module "data" {
  source               = "../../Modules/spoke_data"
  resource_group_name  = var.resource_group_name
  location             = var.location
  rg-n8n-aks-vnet_name = var.data_rg-n8n-aks-vnet_name
  address_space        = var.data_address_space
  address_prefixes     = var.data_address_prefixes
  source_address_prefix_logic = module.logic.address_prefixes[0]
  rg-n8n-aks-nsg_name = var.data_nsg_name
}

module "hub-logic-peering" {
  source                      = "../../Modules/network_peering"
  resource_group_name         = var.resource_group_name
  rg-n8n-aks-vnet_name        = module.hub.virtual_network_name
  remote_virtual_network_id   = module.logic.virtual_network_logic_id
  virtual_network_name        = "${var.rg-n8n-aks-vnet_name}-to-${var.logic_rg-n8n-aks-vnet_name}-peering"
}

module "logic-hub-peering" {
  source                      = "../../Modules/network_peering"
  resource_group_name         = var.resource_group_name
  rg-n8n-aks-vnet_name        = module.logic.virtual_network_name
  remote_virtual_network_id   = module.hub.virtual_network_hub_id
  virtual_network_name        = "${var.logic_rg-n8n-aks-vnet_name}-to-${var.rg-n8n-aks-vnet_name}-peering"
  
}

module "logic-data-peering" {
  source                      = "../../Modules/network_peering"
  resource_group_name         = var.resource_group_name
  rg-n8n-aks-vnet_name        = module.logic.virtual_network_name
  remote_virtual_network_id   = module.data.virtual_network_data_id
  virtual_network_name        = "${var.logic_rg-n8n-aks-vnet_name}-to-${var.data_rg-n8n-aks-vnet_name}-peering"
  
}

module "data-logic-peering" {
  source                      = "../../Modules/network_peering"
  resource_group_name         = var.resource_group_name
  rg-n8n-aks-vnet_name        = module.data.virtual_network_name
  remote_virtual_network_id   = module.logic.virtual_network_logic_id
  virtual_network_name        = "${var.data_rg-n8n-aks-vnet_name}-to-${var.logic_rg-n8n-aks-vnet_name}-peering"
  
}