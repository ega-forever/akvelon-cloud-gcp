/** backend bucket **/
resource "google_compute_backend_bucket" "website-backend-bucket" {
  bucket_name = google_storage_bucket.website_bucket.name
  enable_cdn = "true"
  name = replace(var.website_name, ".", "-")
  lifecycle {
    create_before_destroy = true
  }
}

/** compute url map **/
resource "google_compute_url_map" "website-url-map" {
  default_url_redirect {
    host_redirect = var.website_name
    https_redirect = "false"
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query = "false"
  }

  host_rule {
    hosts = [
      "www.${var.website_name}"]
    path_matcher = "path-matcher-1"
  }

  host_rule {
    hosts = [
      var.website_name
    ]
    path_matcher = "path-matcher-2"
  }

  name = "${replace(var.website_name, ".", "-")}-url-map"

  path_matcher {
    default_url_redirect {
      host_redirect = var.website_name
      https_redirect = "false"
      redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
      strip_query = "false"
    }

    name = "path-matcher-1"
  }

  path_matcher {
    default_service = google_compute_backend_bucket.website-backend-bucket.id
    name = "path-matcher-2"
  }
}

resource "google_compute_url_map" "website-http-redirect-url-map" {
  default_url_redirect {
    https_redirect = "true"
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query = "false"
  }

  name = "${replace(var.website_name, ".", "-")}-http-redirect-url-map"
}

/** proxy **/
resource "google_compute_target_http_proxy" "website-http-target-proxy" {
  name = "${replace(var.website_name, ".", "-")}-http-target-proxy"
  url_map = google_compute_url_map.website-http-redirect-url-map.id
}

resource "google_compute_target_https_proxy" "website-https-target-proxy" {
  name = "${replace(var.website_name, ".", "-")}-https-target-proxy"
  ssl_certificates = [
    google_compute_managed_ssl_certificate.website-ssl.self_link
  ]
  url_map = google_compute_url_map.website-url-map.id
}

/** forwarding rules **/
resource "google_compute_global_forwarding_rule" "website-http-forwarding-rule" {
  ip_address            = google_compute_global_address.website-address.address
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "${replace(var.website_name, ".", "-")}-http-forwarding-rule"
  port_range            = "80-80"
  target                = google_compute_target_http_proxy.website-http-target-proxy.self_link
}

resource "google_compute_global_forwarding_rule" "website-https-forwarding-rule" {
  ip_address = google_compute_global_address.website-address.address
  ip_protocol = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name = "${replace(var.website_name, ".", "-")}-https-forwarding-rule"
  port_range = "443-443"
  target = google_compute_target_https_proxy.website-https-target-proxy.self_link
}