resource "google_container_node_pool" "gke_cluster_pool" {
  autoscaling {
    max_node_count = var.autoscaling_max_nodes_count
    min_node_count = var.autoscaling_min_nodes_count
  }

  cluster = google_container_cluster.gke_cluster.name
  location = var.region

  management {
    auto_repair = "true"
    auto_upgrade = "true"
  }

  name = "${var.gke_cluster_name}-pool"

  node_config {
    machine_type = var.node_pool_instance_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    service_account = var.service_account_email
  }

  upgrade_settings {
    max_surge = "1"
    max_unavailable = "0"
  }

}
