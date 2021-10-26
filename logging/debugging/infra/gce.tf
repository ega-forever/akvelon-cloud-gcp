resource "google_compute_instance" "instance_app" {
  name         = var.instance_app_name
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["ssh", "http"]

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

  metadata_startup_script = file("${path.module}/install.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.account.email
    scopes = ["cloud-platform"]
  }
}