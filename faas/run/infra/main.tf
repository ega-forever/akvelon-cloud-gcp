module "db" {
  source = "./db"
  vpc_id = google_compute_network.vpc_network.id
  region = var.region
  db_name = var.db_name
  databases = ["counter"]
  depends_on = [google_service_networking_connection.private_vpc_connection]
}

module "run_app" {
  source = "./run"
  service_name = "app"
  region = var.region
  docker_image_url = "gcr.io/private-260418/counter"
  cloudsql_connection_name = module.db.proxy_connection
  service_account_email = google_service_account.account.email
  vpc_connector = google_vpc_access_connector.connector.self_link
  env_db_host = module.db.db_address
  env_db_port = "5432"
  env_db_user = module.db.db_user_name
  env_db_password = module.db.db_user_password
  env_db_db = "counter"
  env_db_logging = "1"
}