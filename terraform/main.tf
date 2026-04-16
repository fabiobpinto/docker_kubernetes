########################################################################
### Resource Group
########################################################################
module "rg" {
  source   = "./modules/resource_group"
  rg_name  = var.rg_name
  location = var.location
  tags     = var.tags
}

########################################################################
### Virtual Network
########################################################################
module "network" {
  source   = "./modules/virtual_network"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  tags     = var.tags

  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space
  subnets            = var.subnets
}

########################################################################
### Network Security Group
########################################################################
module "nsg" {
  source   = "./modules/nsg"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  tags     = var.tags

  for_each = var.subnets

  nsg_name      = "nsg-${each.value.name}"
  nsg_subnet_id = module.network.subnet_ids[each.key]
  nsg_rules     = var.nsg_rules[each.value.rule]
}

########################################################################
### Virtual Machines Linux
########################################################################
module "vms_linux" {
  source   = "./modules/vm_linux"
  rg_name  = module.rg.rg_name
  location = module.rg.location
  tags     = var.tags

  for_each = var.vms_linux

  enable_public_ip = try(each.value.enable_public_ip, false)

  vm_linux = {
    admin_username                  = each.value.admin_username
    admin_pass                      = var.admin_pass
    disable_password_authentication = each.value.disable_password_authentication
    vm_name                         = each.value.name
    computer_name                   = each.value.computer_name
    vm_size                         = each.value.size

    os_disk = each.value.os_disk

    source_image_reference = each.value.source_image_reference

  }
  nic_info = {
    name = "nic-${each.value.name}"
    ip_configuration = {
      name                          = "ipconfig-${each.value.name}"
      subnet_id                     = module.network.subnet_ids["linux"]
      private_ip_address_allocation = each.value.nic_info.private_ip_address_allocation
      private_ip_address            = each.value.nic_info.private_ip_address
    }
  }

  auto_shutdown = {
    enabled        = true
    time           = "1900"
    timezone       = "E. South America Standard Time"
    notify         = false
    notify_minutes = 30
    email          = null
  }
}

# ########################################################################
# ### Storage Account
# ########################################################################
# module "storage_account" {
#   source   = "./modules/storage_account"
#   rg_name  = module.rg.rg_name
#   location = module.rg.location
#   tags     = var.tags

#   for_each = var.storage_account

#   stg_name                 = each.value.stg_name
#   account_tier             = each.value.account_tier
#   account_replication_type = each.value.account_replication_type
# }

# module "storage_file_share" {
#   source = "./modules/storage_file_share"

#   for_each = var.storage_account

#   storage_account_id = module.storage_account[each.key].stg_id
#   file_shares        = each.value.file_shares

# }

# ########################################################################
# ### Storage Account - Disable Secure Transfer Requirement
# ########################################################################
# resource "azurerm_storage_account_network_rules" "storage_network_rules" {
#   for_each = var.storage_account

#   storage_account_id = module.storage_account[each.key].stg_id
#   default_action     = "Allow"
# }
