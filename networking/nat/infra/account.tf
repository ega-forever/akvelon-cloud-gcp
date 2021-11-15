resource "google_service_account" "account_nat" {
  account_id   = var.service_account_name
  display_name = var.service_account_name
}

resource "google_project_iam_binding" "account_nat_iam_binding" {
  for_each = toset([
    "roles/compute.admin",
    "roles/iam.serviceAccountUser"
  ])
  role = each.value

  members = [
    "serviceAccount:${google_service_account.account_nat.email}"
  ]
}
