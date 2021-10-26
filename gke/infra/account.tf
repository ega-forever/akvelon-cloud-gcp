resource "google_service_account" "account" {
  account_id = var.service_account_name
  display_name = var.service_account_name
}

resource "google_service_account_key" "account_service_key" {
  service_account_id = google_service_account.account.name
}

resource "google_project_iam_binding" "account_iam_binding" {
  for_each = toset([
    "roles/cloudsql.client"
  ])
  role = each.value

  members = [
    "serviceAccount:${google_service_account.account.email}"
  ]
}