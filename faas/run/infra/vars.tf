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
  default = "vpc-gke"
}

variable "vpc_subnet_cidr" {
  type = string
  default = "10.0.0.0/24"
}

variable "vpc_connector_cidr" {
  type = string
  default = "10.1.0.0/28"
}

variable "db_name" {
  type = string
  default = "db-1632905935259"
}

variable "credentials_path" {
  type = string
  default = "../../../creds/private-token.json"
}