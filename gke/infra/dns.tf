/**
dns zone

Should be imported, if created manually
 **/
resource "google_dns_managed_zone" "website" {
  dns_name = "${var.website_name}."
  name = replace(var.website_name, ".", "-")
  visibility = "public"

  dnssec_config {
    kind = "dns#managedZoneDnsSecConfig"
    non_existence = "nsec3"
    state = "on"

    default_key_specs {
      algorithm = "rsasha256"
      key_length = 2048
      key_type = "keySigning"
      kind = "dns#dnsKeySpec"
    }
    default_key_specs {
      algorithm = "rsasha256"
      key_length = 1024
      key_type = "zoneSigning"
      kind = "dns#dnsKeySpec"
    }
  }
}

/** dns record **/
resource "google_dns_record_set" "website-dns-record-A" {
  managed_zone = replace(var.website_name, ".", "-")
  name = "${var.website_name}."
  rrdatas = [
    google_compute_global_address.website-address.address]
  ttl = "300"
  type = "A"
}

/** address **/
resource "google_compute_global_address" "website-address" {
  address_type = "EXTERNAL"
  ip_version = "IPV4"
  name = replace(var.website_name, ".", "-")
}