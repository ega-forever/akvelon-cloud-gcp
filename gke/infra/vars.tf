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

variable "gke_dev_cluster_name" {
  type = string
  default = "dev-counter-cluster"
}

variable "db_dev_name" {
  type = string
  default = "dev-counter1-db"
}

variable "gke_prod_cluster_name" {
  type = string
  default = "prod-counter-cluster"
}

variable "db_prod_name" {
  type = string
  default = "prod-counter1-db"
}

variable "vpc_subnet_cidr" {
  type = string
  default = "10.0.0.0/24"
}

variable "website_name" {
  type = string
  default = "testsite1632122049153.com"
}

variable "credentials_path" {
  type = string
  default = "../../creds/private-token.json"
}