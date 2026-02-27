output "vms_linux_public_ips" {
  description = "IPs públicos das VMs Linux"
  value = {
    for k, v in module.vms_linux :
    k => v.public_ip_address
    if v.public_ip_address != null
  }
}

output "aks_cluster_names" {
  value = {
    for k, mod in module.aks :
    k => mod.aks_cluster_names
  }
}

output "aks_public_ips" {
  value = {
    for k, mod in module.aks :
    k => mod.aks_public_ips
  }
}


output "next_steps_pretty" {
  value = join(
    "\n\n=============================\n\n",
    flatten([
      for k, mod in module.aks :
      values(mod.next_steps)
    ])
  )
}