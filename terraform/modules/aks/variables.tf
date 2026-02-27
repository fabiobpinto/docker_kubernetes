variable "rg_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type = string
}
variable "tags" {
  type = map(string)
}

variable "aks" {
  description = "Map de clusters AKS a serem criados"

  type = map(object({
    aks_cluster_name = string
    dns_prefix       = string
    identity_type    = string
    vm_size = string
    enable_public_ip = bool
  }))
}