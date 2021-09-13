resource "google_compute_firewall" "vpc_network_ssh_rule" {
  name    = "${var.vpc_name}-ssh-rule"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh"]
}
