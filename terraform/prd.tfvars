rg_name  = "rg-prd-docker"
location = "East US"
########################################################################
### Tags to apply to all resources
########################################################################
tags = {
  environment = "prd"
  owner       = "Fabio Brito Pinto"
  project     = "Azure Docker"
}

########################################################################
### Virtual Network and Subnets configuration
########################################################################
vnet_name          = "vnet-prd"
vnet_address_space = ["10.0.0.0/16"]

subnets = {
  linux = {
    name             = "snet-prd-linux"
    address_prefixes = ["10.0.2.0/24"]
    rule             = "linux"
  }
}

########################################################################
### Network Security Group Rules
########################################################################
nsg_name = "nsg-prd"
nsg_rules = {
  linux = [
    {
      name                   = "Allow-SSH"
      priority               = 1030
      direction              = "Inbound"
      destination_port_range = "22"
    },
    {
      name                   = "Allow-8080"
      priority               = 1040
      direction              = "Inbound"
      destination_port_range = "8080"
    },
    {
      name                   = "Allow-80"
      priority               = 1045
      direction              = "Inbound"
      destination_port_range = "80"
    },
    {
      name                   = "Allow-3000"
      priority               = 1050
      direction              = "Inbound"
      destination_port_range = "3000"
    },
    {
      name                   = "Allow-Postgres"
      priority               = 1060
      direction              = "Inbound"
      destination_port_range = "5432"
    },
    {
      name                   = "Allow-5000"
      priority               = 1061
      direction              = "Inbound"
      destination_port_range = "5000"
    },
    {
      name                   = "Allow-5001"
      priority               = 1062
      direction              = "Inbound"
      destination_port_range = "5001"
    }
  ]
}

########################################################################
# Virtual Machines
########################################################################
admin_username = "adminfabio"

vms_linux = {
  linux = {
    admin_username                  = "adminfabio"
    disable_password_authentication = false
    name                            = "linuxserver"
    computer_name                   = "linuxserver"
    size                            = "Standard_D2ls_v5"
    enable_public_ip                = true

    source_image_reference = {
      publisher = "almalinux"
      offer     = "almalinux-x86_64"
      sku       = "10-gen2"
      version   = "latest"
    }

    plan = {
      publisher = "almalinux"
      product   = "almalinux-x86_64"
      name      = "10-gen2"
    }


    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
    }

    nic_ip_configuration_name = "primary"
    subnet_name               = "snet-prd-linux"

    nic_info = {
      private_ip_address            = "10.0.2.10"
      private_ip_address_allocation = "Static"
    }
  }
}
