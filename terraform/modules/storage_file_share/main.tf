resource "azurerm_storage_share" "this" {
  for_each = var.file_shares

  name               = each.key
  storage_account_id = var.storage_account_id
  quota              = each.value.quota
}
