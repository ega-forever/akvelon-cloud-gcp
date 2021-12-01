resource "google_pubsub_topic" "increment" {
  name = var.pubsub_topic
}