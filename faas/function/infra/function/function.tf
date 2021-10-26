resource "google_cloudfunctions_function" "function" {
  name = var.func_name
  runtime = var.func_runtime
  available_memory_mb = 128
  source_archive_bucket = var.source_bucket
  source_archive_object = var.source_file
  trigger_http = true
  entry_point = var.entry_point
  vpc_connector = var.vpc_connector
  service_account_email = var.service_account_email
  environment_variables = {
    DB_HOST: var.env_db_host
    DB_PORT: var.env_db_port
    DB_USER: var.env_db_user
    DB_PASSWORD: var.env_db_password
    DB_DB: var.env_db_db
    DB_LOGGING: "1"
  }
}

