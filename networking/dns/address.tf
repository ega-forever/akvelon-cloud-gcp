/** address **/
resource "google_compute_global_address" "website-address" {
  address_type = "EXTERNAL"
  ip_version = "IPV4"
  name = replace(var.website_name, ".", "-")
}