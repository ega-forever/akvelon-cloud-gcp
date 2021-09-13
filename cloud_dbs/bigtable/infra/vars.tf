variable "project_id" {
  type = string
  default = "private-260418"
}

variable "region" {
  type = string
  default = "europe-west1"
}

variable "zone" {
  type = string
  default = "europe-west1-b"
}

variable "secondary_zone" {
  type = string
  default = "europe-west1-d"
}

variable "bigtable_cluster_name" {
  type = string
  default = "prod-1"
}

variable "credentials_path" {
  type = string
  default = "../creds/private-260418-83fae3afc6d7.json"
}