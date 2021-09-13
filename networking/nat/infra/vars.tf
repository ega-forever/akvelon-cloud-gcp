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

variable "service_account_name" {
  type = string
  default = "service-account-nat-example"
}

variable "vpc_name" {
  type = string
  default = "vpc-nat"
}

variable "instance_public_name" {
  type = string
  default = "instance-public"
}

variable "instance_private_name" {
  type = string
  default = "instance-private"
}

variable "vpc_subnet_cidr" {
  type = string
  default = "10.0.0.0/24"
}


variable "credentials_path" {
  type = string
  default = "../creds/private-260418-83fae3afc6d7.json"
}