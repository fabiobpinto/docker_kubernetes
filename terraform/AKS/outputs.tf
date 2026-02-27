output "next_steps" {
  value = templatefile("${path.module}/next_steps.tpl", {
    rg_name    = var.resource_group_name
    aks_name   = var.aks_cluster_name
    ip_address = azurerm_public_ip.ingress_ip.ip_address
  })
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "aks_cluster_name" {
  value = var.aks_cluster_name
}