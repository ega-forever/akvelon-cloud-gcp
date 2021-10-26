resource "google_service_account" "account" {
  account_id = var.service_account_name
  display_name = var.service_account_name
}

resource "google_project_iam_binding" "account_iam_binding" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.viewer",
    "roles/monitoring.metricWriter",
    "roles/cloudprofiler.agent",
    "roles/cloudprofiler.user",
    "roles/clouddebugger.agent",
    "roles/clouddebugger.user"])
  role = each.value

  members = [
    "serviceAccount:${google_service_account.account.email}"
  ]
}

