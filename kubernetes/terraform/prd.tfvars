########################################################################
### Tags to apply to all resources
########################################################################
resource_group_name = "rg-aks-kcna"

location = "East US"

tags = {
  environment = "prd"
  owner       = "Fabio Brito Pinto"
  project     = "Azure Docker"
}

aks_cluster_name = "aks-tier"
