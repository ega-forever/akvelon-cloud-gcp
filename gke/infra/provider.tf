provider "google" {
  project = var.project_id
  credentials = var.credentials_path
  region = var.region
}

terraform {
  required_providers {
    google = {
      version = "~> 3.82.0"
    }
  }
}

data "google_client_config" "provider" {}