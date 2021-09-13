resource "google_compute_instance" "instance_public" {
  name         = var.instance_public_name
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.vpc_network_eu_west1_subnet.id

    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.account_nat.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "instance_private" {
  name         = var.instance_private_name
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.vpc_network_eu_west1_subnet.id
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.account_nat.email
    scopes = ["cloud-platform"]
  }
}