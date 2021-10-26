resource "google_storage_bucket" "bucket" {
  name = var.bucket_name
  location = "EU"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}

data "archive_file" "function_zip" {
  type = "zip"
  output_path = "code-${var.func_version}.zip"
  source_dir = var.func_code_path
}

resource "google_storage_bucket_object" "archive" {
  name = "code-${var.func_version}.zip"
  bucket = google_storage_bucket.bucket.name
  source = "code-${var.func_version}.zip"
  depends_on = [
    data.archive_file.function_zip]
}

