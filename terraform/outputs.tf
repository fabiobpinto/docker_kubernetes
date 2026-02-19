output "vms_linux_public_ips" {
  description = "IPs públicos das VMs Linux"
  value = {
    for k, v in module.vms_linux :
    k => v.public_ip_address
    if v.public_ip_address != null
  }
}