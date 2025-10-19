resource "azurerm_kubernetes_cluster" "n8n-aks" {
  name                = var.n8n-aks-name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns-prefix
  

  default_node_pool {
    name       = "default"
    node_count = var.node-count
    vm_size    = var.vm-size
    vnet_subnet_id = var.vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    load_balancer_sku   = "standard"
    service_cidr        = var.service_cidr
    dns_service_ip      = var.dns_service_ip
  }
}