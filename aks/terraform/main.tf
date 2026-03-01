data "azurerm_kubernetes_cluster" "aks_data" {
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = azurerm_kubernetes_cluster.aks.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-aks-tftec-kcna"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksfree"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s" # ideal para camada gratuita
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = "azureuser"

    ssh_key {
      key_data = file("${path.module}/ssh-keys/terraform-azure.pub")
    }
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  }

  tags = var.tags
}

resource "azurerm_public_ip" "ingress_ip" {
  name                = "myAKSPublicIPForIngress"
  location            = azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_kubernetes_cluster.aks_data.node_resource_group
  allocation_method   = "Static"
  sku                 = "Standard"
}