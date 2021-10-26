resource "google_compute_global_forwarding_rule" "mig-global-forwarding-rule-http" {
  name   = "${var.instance_app_name}-forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy_app.self_link
  port_range = "80"
  ip_address = google_compute_global_address.app-lb-address.address
}

resource "google_compute_global_address" "app-lb-address" {
  name = "${var.instance_app_name}-lb-address"
}

resource "google_compute_target_http_proxy" "http_proxy_app" {
  name = "${var.instance_app_name}-proxy"
  url_map = google_compute_url_map.url_map_app.id
}

resource "google_compute_url_map" "url_map_app" {
  name            = "${var.instance_app_name}-url-map"
  default_service = google_compute_backend_service.backend_service_app.id
}

resource "google_compute_backend_service" "backend_service_app" {
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_instance_group_manager.igm_app.instance_group
    balancing_mode = "RATE"
    max_rate = 10
  }

  name        = "${var.instance_app_name}-backend"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = [google_compute_health_check.app_hc.id]
}

resource "google_compute_health_check" "app_hc" {
  name   = "${var.instance_app_name}-hc"
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}
