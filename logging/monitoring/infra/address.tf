resource "google_compute_address" "instance_app_address" {
  address_type = "EXTERNAL"
  name = replace(var.instance_app_name, ".", "-")
}