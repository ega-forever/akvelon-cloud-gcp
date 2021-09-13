resource "google_compute_router" "router" {
  name    = "${var.vpc_name}-router"
  region  = google_compute_subnetwork.vpc_network_eu_west1_subnet.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_address" "address" {
  name   = "${var.vpc_name}-nat-ip-address"

}

resource "google_compute_router_nat" "nat" {
  name   = "${var.vpc_name}-nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.address.*.self_link

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.vpc_network_eu_west1_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}