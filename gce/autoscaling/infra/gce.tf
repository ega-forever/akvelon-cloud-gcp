resource "google_compute_instance_template" "instance_template_app" {
  name = var.instance_app_name
  machine_type = "e2-micro"

  tags = [
    "ssh",
    "http"]

  disk {
    source_image = "debian-cloud/debian-9"
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
    email = google_service_account.account.email
    scopes = [
      "cloud-platform"]
  }
}

resource "google_compute_instance_group_manager" "igm_app" {
  name = "${var.instance_app_name}-igm"
  zone = var.zone

  version {
    instance_template = google_compute_instance_template.instance_template_app.id
    name = "primary"
  }

  base_instance_name = var.instance_app_name
}

resource "google_compute_autoscaler" "autoscaler_app" {
  name = "${var.instance_app_name}-autoscaler"
  zone = var.zone
  target = google_compute_instance_group_manager.igm_app.id

  autoscaling_policy {
    max_replicas = 3
    min_replicas = 1
    cooldown_period = 60

    load_balancing_utilization {
      target = 0.5
    }
  }
}




