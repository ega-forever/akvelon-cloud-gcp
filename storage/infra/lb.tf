resource "google_compute_backend_bucket" "website_backend" {
  name = "${var.bucket_name}-backend"
  bucket_name = google_storage_bucket.website_bucket.name
  enable_cdn = true
}

resource "google_compute_url_map" "website-url-map" {
  name            = "${var.bucket_name}-url-map"
  default_service = google_compute_backend_bucket.website_backend.id
  project         = var.project_id
}

resource "google_compute_global_address" "website-address" {
  address_type  = "EXTERNAL"
  ip_version    = "IPV4"
  name          = "${var.bucket_name}-address"
}

resource "google_compute_target_http_proxy" "website-http-proxy" {
  name    = "${var.bucket_name}-http-target-proxy"
  project = var.project_id
  url_map = google_compute_url_map.website-url-map.id
}

resource "google_compute_global_forwarding_rule" "http" {
  name       = "${var.bucket_name}-http-rule"
  target     = google_compute_target_http_proxy.website-http-proxy.self_link
  ip_address = google_compute_global_address.website-address.address
  port_range = "80"
  depends_on = [google_compute_global_address.website-address]
}