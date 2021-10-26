resource "google_sql_database_instance" "db" {
  database_version = "POSTGRES_12"
  name = var.db_name
  region = var.region
  deletion_protection = false

  settings {
    activation_policy = "ALWAYS"
    availability_type = var.high_availability ? "REGIONAL" : "ZONAL"

    backup_configuration {
      binary_log_enabled = "false"
      enabled = "true"
      location = "eu"
      start_time = "05:00"
    }

    disk_autoresize = "true"
    disk_type = "PD_SSD"

    ip_configuration {
      ipv4_enabled = "false"
      private_network = var.vpc_id
      require_ssl = "false"
    }

    maintenance_window {
      day = "6"
      hour = "9"
    }

    pricing_plan = "PER_USE"
    tier = var.instance_type
  }
}

resource "random_string" "db_user_name" {
  length = 16
  special = true
  override_special = "/@£$"
}

resource "random_string" "db_user_password" {
  length = 16
  special = true
  override_special = "/@£$"
}

resource "google_sql_user" "db_user" {
  name     = random_string.db_user_name.result
  instance = google_sql_database_instance.db.name
  password = random_string.db_user_password.result
}
