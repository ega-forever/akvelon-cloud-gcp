resource "google_container_cluster" "gke_cluster" {

  addons_config {
    horizontal_pod_autoscaling {
      disabled = "false"
    }

    http_load_balancing {
      disabled = "false"
    }

    network_policy_config {
      disabled = "true"
    }
  }

  cluster_autoscaling {
    enabled = "false"
  }

  enable_binary_authorization = "false"
  enable_kubernetes_alpha = "false"
  enable_legacy_abac = "false"
  enable_shielded_nodes = "false"
  initial_node_count = "1"

  location = var.region
  logging_service = "logging.googleapis.com/kubernetes"

  master_auth {
    client_certificate_config {
      issue_client_certificate = "false"
    }
  }

  monitoring_service = "monitoring.googleapis.com/kubernetes"
  name = var.gke_cluster_name
  network = var.vpc_id

  networking_mode="VPC_NATIVE"
  ip_allocation_policy {

  }

  network_policy {
    enabled = "false"
  }

  subnetwork = var.vpc_subnet_id
}
