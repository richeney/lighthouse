locals {
    names = length(var.names) > 0 ? var.names : list(var.name)
}

data "azurerm_resource_group" "vm" {
    name = var.resource_group
}

resource "azurerm_network_interface" "vm" {
    for_each              =  toset(local.names)
    name                  = "${each.value}-nic"
    location              =  data.azurerm_resource_group.vm.location
    resource_group_name   =  data.azurerm_resource_group.vm.name
    tags                  =  data.azurerm_resource_group.vm.tags

    ip_configuration {
        name                          = "ipconfiguration1"
        subnet_id                     =  var.subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_virtual_machine" "vm" {
    for_each              =  toset(local.names)
    name                  =  each.value
    location              =  data.azurerm_resource_group.vm.location
    resource_group_name   =  data.azurerm_resource_group.vm.name
    tags                  =  data.azurerm_resource_group.vm.tags

    network_interface_ids = [ azurerm_network_interface.vm[each.key].id ]
    vm_size               = "Standard_B1ls"

    delete_os_disk_on_termination       = true
    delete_data_disks_on_termination    = true

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    storage_os_disk {
        name                = "${each.value}-os"
        caching             = "ReadWrite"
        create_option       = "FromImage"
        managed_disk_type   = "Standard_LRS"
    }

    os_profile {
        computer_name       =  lower(each.value)
        admin_username      = "lighthouse"
        admin_password      = "StarfishDriftwood31415927!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }
}