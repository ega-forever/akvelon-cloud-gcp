provider "google" {
  project = var.project_id
}

terraform {
  required_providers {
    google = {
      version = "~> 3.82.0"
    }
  }
}

data "google_client_config" "provider" {}