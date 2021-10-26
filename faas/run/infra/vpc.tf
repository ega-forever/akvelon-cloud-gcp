resource "google_compute_network" "vpc_network" {
  name = var.vpc_name
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "vpc_network_eu_west1_subnet" {
  name = var.region
  ip_cidr_range = var.vpc_subnet_cidr
  region = var.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_global_address" "private_ip_address" {
  name = google_compute_network.vpc_network.name
  purpose = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 16
  network = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network = google_compute_network.vpc_network.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private_ip_address.name]
}

resource "google_vpc_access_connector" "connector" {
  name = "${var.vpc_name}-connector"
  ip_cidr_range = var.vpc_connector_cidr
  network = google_compute_network.vpc_network.name
}
