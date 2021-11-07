resource "google_pubsub_topic" "increment" {
  name = var.pubsub_topic
}

resource "google_pubsub_subscription" "increment_subscription" {
  name  = var.pubsub_subscription
  topic = google_pubsub_topic.increment.name
  ack_deadline_seconds = 60
}