output "service_name" {
  value = google_cloud_run_service.app_service.name
}

output "service_url" {
  value = google_cloud_run_service.app_service.status[0].url
}

output "service_location" {
  value = google_cloud_run_service.app_service.location
}