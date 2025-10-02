resource "azurerm_linux_virtual_machine" "n8n-vm" {
    name                = "n8n-vm"
    resource_group_name = var.resource_group_name
    location            = var.location
    size                = "Standard_B1s"
    admin_username      = var.admin_username
    admin_password      = var.admin_password
    disable_password_authentication = "false"

    network_interface_ids = [
        var.network_interface_id,
    ]

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "ubuntu-24_04-lts"
        sku       = "server"
        version   = "latest"
    }
}