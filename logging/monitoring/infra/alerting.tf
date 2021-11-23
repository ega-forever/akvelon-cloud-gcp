resource "google_monitoring_uptime_check_config" "http_uptime_check" {
  display_name = "instance-app-http-check"
  timeout = "10s"
  period = "60s"

  http_check {
    path = "/"
    port = "80"
    request_method = "GET"
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      host = google_compute_instance.instance_app.network_interface.0.access_config.0.nat_ip
    }
  }
}

resource "google_monitoring_notification_channel" "mail_notification_channel" {
  display_name = "http health check notification channel"
  type = "email"
  labels = {
    email_address = var.notification_email
  }
}

resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = "Uptime Health Check on instance-app-http-check"
  combiner = "OR"
  conditions {
    display_name = "Uptime Check URL - Check passed"
    condition_threshold {
      filter = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"uptime_url\" metric.label.\"check_id\"=\"${google_monitoring_uptime_check_config.http_uptime_check.uptime_check_id}\""
      duration = "0s"
      comparison = "COMPARISON_GT"
      threshold_value = 1
      aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_NEXT_OLDER"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
      }
      trigger {
        count = 1
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.mail_notification_channel.id
  ]
}

