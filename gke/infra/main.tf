module cluster_dev {
  source = "./cluster"
  vpc_id = google_compute_network.vpc_network.id
  vpc_subnet_id = google_compute_subnetwork.vpc_network_eu_west1_subnet.id
  region = var.region
  service_account_email = google_service_account.account.email
  gke_cluster_name = var.gke_dev_cluster_name
}

module db_dev {
  source = "./db"
  vpc_id = google_compute_network.vpc_network.id
  region = var.region
  db_name = var.db_dev_name
  databases = ["counter"]
  depends_on = [google_service_networking_connection.private_vpc_connection]
}

module gke_secrets_dev {
  source = "./gke_secrets"
  host = module.cluster_dev.host_endpoint
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = module.cluster_dev.cluster_ca_certificate
  db_username = module.db_dev.db_user_name
  db_password = module.db_dev.db_user_password
  service_account_db_private_key = google_service_account_key.account_service_key.private_key
}

module cluster_prod {
  source = "./cluster"
  vpc_id = google_compute_network.vpc_network.id
  vpc_subnet_id = google_compute_subnetwork.vpc_network_eu_west1_subnet.id
  region = var.region
  service_account_email = google_service_account.account.email
  gke_cluster_name = var.gke_prod_cluster_name
}

module db_prod {
  source = "./db"
  vpc_id = google_compute_network.vpc_network.id
  region = var.region
  db_name = var.db_prod_name
  high_availability = true
  databases = ["counter"]
  depends_on = [google_service_networking_connection.private_vpc_connection]
}

module gke_secrets_prod {
  source = "./gke_secrets"
  host = module.cluster_prod.host_endpoint
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = module.cluster_prod.cluster_ca_certificate
  db_username = module.db_prod.db_user_name
  db_password = module.db_prod.db_user_password
  service_account_db_private_key = google_service_account_key.account_service_key.private_key
}