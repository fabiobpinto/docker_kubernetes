variable "storage_account_id" {
  type = string
}

variable "file_shares" {
  type = map(object({
    quota = number
  }))
}
