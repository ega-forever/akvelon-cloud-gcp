variable "service_name" {
  type = string
}

variable "region" {
  type = string
}

variable "docker_image_url" {
  type = string
}

variable "cloudsql_connection_name" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "vpc_connector" {
  type = string
}

variable "env_db_host" {
  type = string
}

variable "env_db_port" {
  type = string
}

variable "env_db_user" {
  type = string
}

variable "env_db_password" {
  type = string
}

variable "env_db_db" {
  type = string
}

variable "env_db_logging" {
  type = string
}