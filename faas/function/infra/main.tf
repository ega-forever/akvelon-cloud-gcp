module "db" {
  source = "./db"
  vpc_id = google_compute_network.vpc_network.id
  region = var.region
  db_name = var.db_name
  databases = ["counter"]
  depends_on = [google_service_networking_connection.private_vpc_connection]
}

module "func_increment" {
  source = "./function"
  source_bucket = google_storage_bucket.bucket.name
  source_file = google_storage_bucket_object.archive.name
  entry_point = var.func_call_increment_method
  func_name = var.func_increment_name
  func_code_path = var.func_code_path
  func_runtime = var.func_runtime
  vpc_connector = google_vpc_access_connector.connector.self_link
  service_account_email = google_service_account.account.email
  env_db_host = module.db.db_address
  env_db_port = "5432"
  env_db_user = module.db.db_user_name
  env_db_password = module.db.db_user_password
  env_db_db = "counter"
}

module "func_get" {
  source = "./function"
  source_bucket = google_storage_bucket.bucket.name
  source_file = google_storage_bucket_object.archive.name
  entry_point = var.func_call_get_method
  func_name = var.func_get_name
  func_code_path = var.func_code_path
  func_runtime = var.func_runtime
  vpc_connector = google_vpc_access_connector.connector.self_link
  service_account_email = google_service_account.account.email
  env_db_host = module.db.db_address
  env_db_port = "5432"
  env_db_user = module.db.db_user_name
  env_db_password = module.db.db_user_password
  env_db_db = "counter"
}