/** ssl **/
resource "google_compute_managed_ssl_certificate" "website-ssl" {
  name = "${replace(var.website_name, ".", "-")}-ssl"
  managed {
    domains = [
      google_dns_record_set.website-dns-record-A.name]
  }
}
