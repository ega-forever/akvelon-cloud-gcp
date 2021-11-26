variable "project_id" {
  type = string
  default = "private-260418"
}

variable "region" {
  type = string
  default = "europe-west1"
}

variable "service_account_name" {
  type = string
  default = "service-account-example"
}

variable "vpc_name" {
  type = string
  default = "vpc-function"
}

variable "vpc_subnet_cidr" {
  type = string
  default = "10.0.0.0/24"
}

variable "vpc_connector_cidr" {
  type = string
  default = "10.1.0.0/28"
}

variable "bucket_name" {
  type = string
  default = "code_bucket_1632905935258"
}

variable "db_name" {
  type = string
  default = "db-1632905935258"
}

variable "func_increment_name" {
  type = string
  default = "func-1632905935258-increment"
}

variable "func_get_name" {
  type = string
  default = "func-1632905935258-get"
}

variable "func_code_path" {
  type = string
  default = "../app/build"
}

variable "func_runtime" {
  type = string
  default = "nodejs14"
}

variable "func_version" {
  type = string
  default = "1.0.2"
}

variable "func_call_get_method" {
  type = string
  default = "get"
}

variable "func_call_increment_method" {
  type = string
  default = "increment"
}