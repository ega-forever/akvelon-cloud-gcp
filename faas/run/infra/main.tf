module "db" {
  source = "./db"
  vpc_id = var.vpc_id
  region = var.region
  db_name = var.db_name
  databases = ["counter"]
  depends_on = [google_service_networking_connection.private_vpc_connection]
}

module "run_app_rest" {
  source = "./run"
  service_name = "app-rest"
  region = var.region
  docker_image_url = var.run_image
  cloudsql_connection_name = module.db.proxy_connection
  service_account_email = google_service_account.account.email
  vpc_connector = google_vpc_access_connector.connector.self_link
  env_db_host = module.db.db_address
  env_db_port = "5432"
  env_db_user = module.db.db_user_name
  env_db_password = module.db.db_user_password
  env_db_db = "counter"
  env_db_logging = "1"
  env_gql_introspection = "1"
  env_gql_playground = "1"
  env_google_pubsub_topic_increment = var.pubsub_topic
  run_container_args = ["build/src/rest/index.js" ]
}

module "run_app_worker" {
  source = "./run"
  service_name = "app-worker"
  region = var.region
  docker_image_url = var.run_image
  cloudsql_connection_name = module.db.proxy_connection
  service_account_email = google_service_account.account.email
  vpc_connector = google_vpc_access_connector.connector.self_link
  env_db_host = module.db.db_address
  env_db_port = "5432"
  env_db_user = module.db.db_user_name
  env_db_password = module.db.db_user_password
  env_db_db = "counter"
  env_db_logging = "1"
  env_gql_introspection = "1"
  env_gql_playground = "1"
  env_google_pubsub_topic_increment = var.pubsub_topic
  run_container_args = ["build/src/worker/index.js" ]
}