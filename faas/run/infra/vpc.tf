resource "google_compute_global_address" "private_ip_address" {
  name = var.run_name
  purpose = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 16
  network = var.vpc_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network = var.vpc_id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private_ip_address.name]
}

resource "google_vpc_access_connector" "connector" {
  name = "${var.run_name}-connector"
  ip_cidr_range = var.vpc_connector_cidr
  network = var.vpc_name
}
