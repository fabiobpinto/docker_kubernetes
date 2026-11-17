subscription_id = "ff882453-92d9-4cdd-a627-966b0727aeec"

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
      name                   = "Allow-9000"
      priority               = 1042
      direction              = "Inbound"
      destination_port_range = "9000"
    },
    {
      name                   = "Allow-80"
      priority               = 1045
      direction              = "Inbound"
      destination_port_range = "80"
    },
    {
      name                   = "Allow-HTTPS"
      priority               = 1046
      direction              = "Inbound"
      destination_port_range = "443"
    },
    {
      name                   = "Allow-Postgres"
      priority               = 1060
      direction              = "Inbound"
      destination_port_range = "5432"
    },
    {
      name                   = "Allow-30004"
      priority               = 1061
      direction              = "Inbound"
      destination_port_range = "30004"
    },
    {
      name                   = "Allow-30005"
      priority               = 1062
      direction              = "Inbound"
      destination_port_range = "30005"
    },
    {
      name                   = "Allow-30006"
      priority               = 1063
      direction              = "Inbound"
      destination_port_range = "30006"
    },
    {
      name                   = "Allow-MinikubeDashboard"
      priority               = 1070
      direction              = "Inbound"
      destination_port_range = "43185"
    },
    {
      name                   = "Allow-Prometheus"
      priority               = 1080
      direction              = "Inbound"
      destination_port_range = "9090"
    },
    {
      name                   = "Allow-Grafana"
      priority               = 1090
      direction              = "Inbound"
      destination_port_range = "3000"
    },
    {
      name                   = "Allow-AlertManager"
      priority               = 1100
      direction              = "Inbound"
      destination_port_range = "9093"
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
    size                            = "Standard_B2as_v2"
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
      storage_account_type = "StandardSSD_LRS"
      disk_size_gb         = 30
    }

    nic_ip_configuration_name = "primary"
    subnet_name               = "snet-prd-linux"

    nic_info = {
      private_ip_address            = "10.0.2.10"
      private_ip_address_allocation = "Static"
    }
  },
  rh8 = {
    admin_username                  = "adminfabio"
    disable_password_authentication = false
    name                            = "rh8"
    computer_name                   = "rh8"
    size                            = "Standard_B2as_v2"
    enable_public_ip                = true

    source_image_reference = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "8-lvm-gen2"
      version   = "latest"
    }

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "StandardSSD_LRS"
      disk_size_gb         = 64
    }

    nic_ip_configuration_name = "primary"
    subnet_name               = "snet-prd-linux"

    nic_info = {
      private_ip_address            = "10.0.2.20"
      private_ip_address_allocation = "Static"
    }
  },
  rh9 = {
    admin_username                  = "adminfabio"
    disable_password_authentication = false
    name                            = "rh9"
    computer_name                   = "rh9"
    size                            = "Standard_B2as_v2"
    enable_public_ip                = true

    source_image_reference = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "9-lvm-gen2"
      version   = "latest"
    }

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "StandardSSD_LRS"
      disk_size_gb         = 64
    }

    nic_ip_configuration_name = "primary"
    subnet_name               = "snet-prd-linux"

    nic_info = {
      private_ip_address            = "10.0.2.30"
      private_ip_address_allocation = "Static"
    }
  },
}
