output "stg_name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.stg.name
}

output "stg_id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.stg.id
}
