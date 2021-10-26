variable "func_name" {
  type = string
}

variable "source_bucket" {
  type = string
}

variable "source_file" {
  type = string
}

variable "entry_point" {
  type = string
}

variable "vpc_connector" {
  type = string
}

variable "func_code_path" {
  type = string
}

variable "func_runtime" {
  type = string
}

variable "service_account_email" {
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