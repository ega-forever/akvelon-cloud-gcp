resource "google_bigtable_instance" "production-instance" {
  name = var.bigtable_cluster_name
  cluster {
    cluster_id   = var.bigtable_cluster_name
    num_nodes    = 1
    storage_type = "SSD"
    zone = var.zone
  }
}