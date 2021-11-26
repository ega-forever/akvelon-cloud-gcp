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
  default = "service-account-run"
}

# this is default network's VPC. Custom networks can't be deleted as there is a bug with cloud run
variable "vpc_id" {
  type = string
  default = "projects/private-260418/global/networks/default"
}

variable "vpc_name" {
  type = string
  default = "default"
}

variable "vpc_connector_cidr" {
  type = string
  default = "10.1.0.0/28"
}

variable "db_name" {
  type = string
  default = "db-1632905935259"
}

variable "run_image" {
  type = string
  default = "gcr.io/private-260418/counter"
}

variable "run_name" {
  type = string
  default = "incrementer"
}