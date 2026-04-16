variable "rg_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "The Azure region where the resources will be deployed."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource group."
}

variable "stg_name" {
  type        = string
  description = "Storage account name"
}

variable "account_tier" {
  type        = string
  description = "The account tier of the storage account. Valid values are Standard and Premium."
}

variable "account_replication_type" {
  type        = string
  description = "The replication type of the storage account. Valid values are LRS, GRS, RAGRS, ZRS."
}
