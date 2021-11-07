variable "project_id" {
  type = string
  default = "private-260418"
}

variable "region" {
  type = string
  default = "europe-west1"
}

variable "service_account_db_name" {
  type = string
  default = "service-account-db"
}

variable "service_account_cluster_name" {
  type = string
  default = "service-account-cluster"
}

variable "service_account_pubsub_name" {
  type = string
  default = "service-account-pubsub"
}

variable "vpc_name" {
  type = string
  default = "vpc-gke-increment"
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

variable "pubsub_dev_topic" {
  type = string
  default = "dev_increment"
}

variable "pubsub_dev_subscription" {
  type = string
  default = "dev_increment_subscription"
}

variable "pubsub_prod_topic" {
  type = string
  default = "prod_increment"
}

variable "pubsub_prod_subscription" {
  type = string
  default = "prod_increment_subscription"
}