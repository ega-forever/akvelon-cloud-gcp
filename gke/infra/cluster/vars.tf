variable "region" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_subnet_id" {
  type = string
}

variable "gke_cluster_name" {
  type = string
}

variable "autoscaling_min_nodes_count" {
  type = number
  default = 1
}

variable "autoscaling_max_nodes_count" {
  type = number
  default = 5
}

variable "node_pool_instance_type" {
  type = string
  default = "e2-medium"
}