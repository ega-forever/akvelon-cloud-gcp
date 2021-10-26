resource "google_storage_bucket" "website_bucket" {
  name = replace(var.website_name, ".", "-")
  location = "EU"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
  website {
    main_page_suffix = "index.html"
    not_found_page = "404.html"
  }
}

resource "google_storage_bucket_iam_member" "website_permission" {
  bucket = google_storage_bucket.website_bucket.name
  role = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_object" "website_css_files" {
  for_each = fileset(path.module, "bucket_data/*.css")
  name   = basename(each.value)
  source = each.value
  content_type = "text/css"
  bucket = google_storage_bucket.website_bucket.id
}

resource "google_storage_bucket_object" "website_js_files" {
  for_each = fileset(path.module, "bucket_data/*.js")
  name   = basename(each.value)
  source = each.value
  content_type = "text/javascript"
  bucket = google_storage_bucket.website_bucket.id
}

resource "google_storage_bucket_object" "website_html_files" {
  for_each = fileset(path.module, "bucket_data/*.html")
  name   = basename(each.value)
  source = each.value
  content_type = "text/html"
  bucket = google_storage_bucket.website_bucket.id
}