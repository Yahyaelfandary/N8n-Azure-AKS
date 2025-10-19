terraform {
  backend "azurerm" {
    resource_group_name  = "n8n-app-storage"
    storage_account_name = "tfstateaccountn8n"
    container_name       = "tfstatecontainer"
    key                  = "prod-terraform.tfstate"
  }
}