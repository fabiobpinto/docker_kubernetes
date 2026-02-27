output "aks_cluster_names" {
  description = "Nome dos clusters AKS criados"

  value = {
    for k, v in azurerm_kubernetes_cluster.aks :
    k => v.name
  }
}

output "aks_public_ips" {
  description = "Public IPs criados para os AKS"

  value = {
    for k, v in azurerm_public_ip.pip :
    k => v.ip_address
  }
}

output "next_steps" {
  value = {
    for k, cluster in azurerm_kubernetes_cluster.aks :
    k => templatefile("${path.module}/next_steps.tpl", {
      rg_name    = var.rg_name
      aks_name   = cluster.name
      ip_address = try(azurerm_public_ip.pip[k].ip_address, "No Public IP")
    })
  }
}