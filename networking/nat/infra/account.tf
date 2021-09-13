resource "google_service_account" "account_nat" {
  account_id   = var.service_account_name
  display_name = var.service_account_name
}

data "google_iam_policy" "account_policy" {
  binding {
    role = "roles/compute.Viewer"

    members = [
      google_service_account.account_nat.id,
    ]
  }
}