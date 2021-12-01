resource "google_service_account" "account" {
  account_id   = var.service_account_name
  display_name = var.service_account_name
}

resource "google_project_iam_binding" "account_iam_binding" {
  for_each = toset([
    "roles/cloudsql.client",
    "roles/pubsub.publisher",
    "roles/pubsub.subscriber",
    "roles/pubsub.viewer",
    "roles/iam.serviceAccountTokenCreator"
  ])
  role     = each.value

  members = [
    "serviceAccount:${google_service_account.account.email}"
  ]
}

resource "google_cloud_run_service_iam_member" "invoker_rest" {
  service  = module.run_app_rest.service_name
  role     = "roles/run.invoker"
  member   = "allUsers"
  location = var.region
}

resource "google_cloud_run_service_iam_member" "invoker_worker" {
  service  = module.run_app_worker.service_name
  location = var.region
  role     = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.account.email}"
  depends_on = [module.run_app_worker]
}

resource "google_project_iam_binding" "pubsub_account_iam_binding" {
  role     = "roles/iam.serviceAccountTokenCreator"
  members = [
    "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
  ]
}