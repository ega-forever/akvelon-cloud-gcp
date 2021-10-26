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

resource "google_dns_record_set" "website-dns-record-CNAME" {
  managed_zone = replace(var.website_name, ".", "-")
  name         = "www.${var.website_name}."
  project      = var.project_id
  rrdatas      = ["${var.website_name}."]
  ttl          = "300"
  type         = "CNAME"
}

