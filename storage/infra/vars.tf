variable "project_id" {
  type = string
  default = "private-260418"
}

variable "region" {
  type = string
  default = "eu-west1"
}

variable "credentials_path" {
  type = string
  default = "../creds/private-token.json"
}

variable "bucket_name" {
  type = string
  default = "website-bucket-1632067139786"
}