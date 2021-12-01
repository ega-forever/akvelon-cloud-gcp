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

variable "env_gql_introspection" {
  type = string
}

variable "env_gql_playground" {
  type = string
}

variable "env_google_pubsub_topic_increment" {
  type = string
}

variable "env_google_pubsub_subscription_increment" {
  type = string
  default = null
}

variable "run_container_command" {
  type = list(string)
  default = ["node"]
}

variable "run_container_args" {
  type = list(string)
}
