output "website-address" {
  value = google_compute_global_address.website-address.address
}

output "website-url" {
  value = var.website_name
}