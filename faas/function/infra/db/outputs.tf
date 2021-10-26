output "db_address" {
  value = google_sql_database_instance.db.private_ip_address
}

output "db_user_name" {
  value = random_string.db_user_name.result
}

output "db_user_password" {
  value = random_string.db_user_password.result
}

output "proxy_connection" {
  value = google_sql_database_instance.db.connection_name
}