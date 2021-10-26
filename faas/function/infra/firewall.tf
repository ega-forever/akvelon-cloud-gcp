resource "google_compute_firewall" "vpc_network_ssh_rule" {
  name    = "${var.vpc_name}-ssh-rule"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "vpc_network_http_rule" {
  name    = "${var.vpc_name}-http-rule"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_firewall" "vpc_network_sql_rule" {
  name    = "${var.vpc_name}-pgsql-rule"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["3307"]
  }
}