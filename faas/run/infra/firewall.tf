resource "google_compute_firewall" "vpc_network_http_rule" {
  name    = "${var.run_name}-http-rule"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}