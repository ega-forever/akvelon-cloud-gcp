resource "google_service_account" "account_cluster" {
  account_id = var.service_account_cluster_name
  display_name = var.service_account_cluster_name
}

resource "google_service_account" "account_db" {
  account_id = var.service_account_db_name
  display_name = var.service_account_db_name
}

resource "google_service_account_key" "account_db_service_key" {
  service_account_id = google_service_account.account_db.name
}

resource "google_project_iam_binding" "account_db_iam_binding" {
  for_each = toset([
    "roles/cloudsql.client"
  ])
  role = each.value

  members = [
    "serviceAccount:${google_service_account.account_db.email}"
  ]
}



resource "google_service_account" "account_pubsub" {
  account_id = var.service_account_pubsub_name
  display_name = var.service_account_pubsub_name
}

resource "google_service_account_key" "account_pubsub_service_key" {
  service_account_id = google_service_account.account_pubsub.name
}

resource "google_project_iam_binding" "account_pubsub_iam_binding" {
  for_each = toset([
    "roles/pubsub.publisher",
    "roles/pubsub.subscriber",
    "roles/pubsub.viewer"
  ])
  role = each.value

  members = [
    "serviceAccount:${google_service_account.account_pubsub.email}"
  ]
}

