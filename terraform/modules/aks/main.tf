data "azurerm_kubernetes_cluster" "aks_data" {
  for_each = azurerm_kubernetes_cluster.aks

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_public_ip" "pip" {
  for_each = {
    for k, v in var.aks : k => v
    if v.enable_public_ip
  }

  name                = "pip-${each.value.aks_cluster_name}"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.aks

  name                = each.value.aks_cluster_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = each.value.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = each.value.vm_size
  }

  identity {
    type = each.value.identity_type
  }

  tags = var.tags
}
