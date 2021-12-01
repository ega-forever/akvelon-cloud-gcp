resource "google_eventarc_trigger" "trigger_increment" {
  name = "trigger"
  location = var.region
  service_account = google_service_account.account.email
  matching_criteria {
    attribute = "type"
    value = "google.cloud.pubsub.topic.v1.messagePublished"
  }
  destination {
    cloud_run_service {
      service = module.run_app_worker.service_name
      region = var.region
    }
  }

  transport {
    pubsub {
      topic = google_pubsub_topic.increment.id
    }
  }
}