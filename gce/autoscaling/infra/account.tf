resource "google_service_account" "account" {
  account_id   = var.service_account_name
  display_name = var.service_account_name
}