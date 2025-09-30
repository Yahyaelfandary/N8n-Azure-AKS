provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "hub" {
  source                 = "../../Modules/Network/hub-VNet"
  resource_group_name    = var.resource_group_name
  location               = var.location
  rg-n8n-aks-nsg_name    = var.rg-n8n-aks-nsg_name
  rg-n8n-aks-vnet_name   = var.rg-n8n-aks-vnet_name
  address_space          = var.address_space
  source_address_dev     = var.source_address_dev
  address_prefixes       = var.address_prefixes
  jumpserver_subnet_name = var.hub_jumpserver_subnet_name
  JumpServerPublicIP     = var.JumpServerPublicIP
}

module "logic" {
  source               = "../../Modules/Network/spoke_logic"
  resource_group_name  = var.resource_group_name
  location             = var.location
  rg-n8n-aks-vnet_name = var.logic_rg-n8n-aks-vnet_name
  address_space        = var.logic_address_space
  address_prefixes     = var.logic_address_prefixes
  subnet_name          = var.logic_subnet_name
}

module "data" {
  source                      = "../../Modules/Network/spoke_data"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  rg-n8n-aks-vnet_name        = var.data_rg-n8n-aks-vnet_name
  address_space               = var.data_address_space
  address_prefixes            = var.data_address_prefixes
  source_address_prefix_logic = module.hub.address_prefixes[0]
  rg-n8n-aks-nsg_name         = var.data_nsg_name
}

module "hub-logic-peering" {
  source                    = "../../Modules/Network/network_peering"
  resource_group_name       = var.resource_group_name
  rg-n8n-aks-vnet_name      = module.hub.virtual_network_name
  remote_virtual_network_id = module.logic.virtual_network_logic_id
  virtual_network_name      = "${var.rg-n8n-aks-vnet_name}-to-${var.logic_rg-n8n-aks-vnet_name}-peering"
}

module "logic-hub-peering" {
  source                    = "../../Modules/Network/network_peering"
  resource_group_name       = var.resource_group_name
  rg-n8n-aks-vnet_name      = module.logic.virtual_network_name
  remote_virtual_network_id = module.hub.virtual_network_hub_id
  virtual_network_name      = "${var.logic_rg-n8n-aks-vnet_name}-to-${var.rg-n8n-aks-vnet_name}-peering"

}

module "hub-data-peering" {
  source                    = "../../Modules/Network/network_peering"
  resource_group_name       = var.resource_group_name
  rg-n8n-aks-vnet_name      = module.hub.virtual_network_name
  remote_virtual_network_id = module.data.virtual_network_data_id
  virtual_network_name      = "${var.rg-n8n-aks-vnet_name}-to-${var.data_rg-n8n-aks-vnet_name}-peering"

}

module "data-hub-peering" {
  source                    = "../../Modules/Network/network_peering"
  resource_group_name       = var.resource_group_name
  rg-n8n-aks-vnet_name      = module.data.virtual_network_name
  remote_virtual_network_id = module.hub.virtual_network_hub_id
  virtual_network_name      = "${var.data_rg-n8n-aks-vnet_name}-to-${var.rg-n8n-aks-vnet_name}-peering"

}

module "p-dns-zone" {
  source              = "../../Modules/Network/Private-DNS/Main"
  p_dns_zone_name     = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  depends_on          = [module.hub, module.logic, module.data]

}

module "psql-p-dns-zone" {
  source              = "../../Modules/Network/Private-DNS/Main"
  p_dns_zone_name     = var.postgres_private_dns_zone_name
  resource_group_name = var.resource_group_name
  depends_on          = [module.hub, module.logic, module.data]
  
}

module "p-dns-hub-link" {
  source                = "../../Modules/Network/Private-DNS/Links"
  private_dns_zone_name = module.p-dns-zone.private_dns_zone_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = module.hub.virtual_network_hub_id
  link_name             = "${module.p-dns-zone.private_dns_zone_name}-to-${var.rg-n8n-aks-vnet_name}-link"
  registration_status   = var.registration_status
}

module "p-dns-logic-link" {
  source                = "../../Modules/Network/Private-DNS/Links"
  private_dns_zone_name = module.p-dns-zone.private_dns_zone_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = module.logic.virtual_network_logic_id
  link_name             = "${module.p-dns-zone.private_dns_zone_name}-to-${var.logic_rg-n8n-aks-vnet_name}-link"
  registration_status   = false

  depends_on = [module.p-dns-hub-link]
}

module "p-dns-data-link" {
  source                = "../../Modules/Network/Private-DNS/Links"
  private_dns_zone_name = module.p-dns-zone.private_dns_zone_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = module.data.virtual_network_data_id
  link_name             = "${module.p-dns-zone.private_dns_zone_name}-to-${var.data_rg-n8n-aks-vnet_name}-link"
  registration_status   = false

  depends_on = [module.p-dns-logic-link]
}

module "psql-p-dns-hub-link" {
  source                = "../../Modules/Network/Private-DNS/Links"
  private_dns_zone_name = module.psql-p-dns-zone.private_dns_zone_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = module.hub.virtual_network_hub_id
  link_name             = "${module.psql-p-dns-zone.private_dns_zone_name}-to-${var.rg-n8n-aks-vnet_name}-link"
  registration_status   = false

  depends_on = [ module.psql-p-dns-zone ]
}

module "psql-p-dns-data-link" {
  source                = "../../Modules/Network/Private-DNS/Links"
  private_dns_zone_name = module.psql-p-dns-zone.private_dns_zone_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = module.data.virtual_network_data_id
  link_name             = "${module.psql-p-dns-zone.private_dns_zone_name}-to-${var.data_rg-n8n-aks-vnet_name}-link"
  registration_status   = false

  depends_on = [ module.psql-p-dns-logic-link ]
  
}

module "psql-p-dns-logic-link" {
  source                = "../../Modules/Network/Private-DNS/Links"
  private_dns_zone_name = module.psql-p-dns-zone.private_dns_zone_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = module.logic.virtual_network_logic_id
  link_name             = "${module.psql-p-dns-zone.private_dns_zone_name}-to-${var.logic_rg-n8n-aks-vnet_name}-link"
  registration_status   = false

  depends_on = [ module.psql-p-dns-hub-link ]
  
}

module "psql-server" {
  source                 = "../../Modules/Database/Postegresql/Server"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.psql_admin_username
  administrator_password = var.psql_admin_password
  psql_server            = var.psql_server_name
  delegated_subnet_id    = module.data.subnet_id
  private_dns_zone_id    = module.psql-p-dns-zone.private_dns_zone_id

  depends_on = [ module.psql-p-dns-data-link ]
}

module "DB" {
  source         = "../../Modules/Database/Postegresql/DB"
  psql_db_name   = var.database_name
  psql_server_id = module.psql-server.psql_server_id

  depends_on = [ module.psql-server ]
}