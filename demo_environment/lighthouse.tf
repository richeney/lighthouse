provider "azurerm" {
  version = "~>1.44.0"

  // I use these to ensure I am deploying to the right place.
  // Assuming CLI or CloudShell authentication, or service principal
  // with exported ARM_CLIENT_ID and ARM_CLIENT_SECRET
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

//=======================================================================

resource "azurerm_resource_group" "rnd" {
  name     = "researchAndDevelopment"
  location = "West Europe"
}


resource "azurerm_storage_account" "rnd" {
  name                = "lighthouseresearch"
  resource_group_name = azurerm_resource_group.rnd.name
  location            = azurerm_resource_group.rnd.location
  tags                = azurerm_resource_group.rnd.tags

  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

//=======================================================================

resource "azurerm_resource_group" "shared" {
  name     = "sharedServices"
  location = "West Europe"
}

//=======================================================================

resource "azurerm_resource_group" "vms" {
  name     = "virtualMachines"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vms" {
  name                = "vNet"
  resource_group_name = azurerm_resource_group.vms.name
  location            = azurerm_resource_group.vms.location
  tags                = azurerm_resource_group.vms.tags

  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "vms" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.vms.name
  virtual_network_name = azurerm_virtual_network.vms.name
  address_prefix       = "10.0.2.0/24"
}

module "vm" {
  source = "./vm"

  resource_group = azurerm_resource_group.vms.name
  subnet_id      = azurerm_subnet.vms.id
  names = [
    "LighthouseCustomer-vm1",
    "LighthouseCustomer-vm2",
    "LighthouseCustomer-vm3"
  ]
}
