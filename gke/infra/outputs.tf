output "gke_dev_context_add_command" {
  value = "gcloud container clusters get-credentials ${var.gke_dev_cluster_name} --region ${var.region}"
}

output "db_dev_connection_proxy" {
  value = module.db_dev.proxy_connection
}

output "gke_prod_context_add_command" {
  value = "gcloud container clusters get-credentials ${var.gke_prod_cluster_name} --region ${var.region}"
}

output "db_prod_connection_proxy" {
  value = module.db_prod.proxy_connection
}