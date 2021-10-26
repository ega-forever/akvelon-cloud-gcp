variable "vpc_id" {
  type = string
}

variable "region" {
  type = string
}

variable "db_name" {
  type = string
}

variable "high_availability" {
  type = bool
  default = false
}

variable "databases" {
  type = set(string)
  default = []
}

variable "instance_type" {
  type = string
  default = "db-f1-micro"
}