resource "google_cloud_run_service" "app_service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      service_account_name = var.service_account_email

      containers {
        image = var.docker_image_url
        command = var.run_container_command
        args = var.run_container_args

        env {
          name  = "DB_HOST"
          value = var.env_db_host
        }
        env {
          name  = "DB_PORT"
          value = var.env_db_port
        }
        env {
          name  = "DB_USER"
          value = var.env_db_user
        }
        env {
          name  = "DB_PASSWORD"
          value = var.env_db_password
        }
        env {
          name  = "DB_DB"
          value = var.env_db_db
        }
        env {
          name  = "DB_LOGGING"
          value = var.env_db_logging
        }
        env {
          name  = "GQL_INTROSPECTION"
          value = var.env_gql_introspection
        }
        env {
          name  = "GQL_PLAYGROUND"
          value = var.env_gql_playground
        }
        env {
          name  = "GOOGLE_PUBSUB_TOPIC_INCREMENT"
          value = var.env_google_pubsub_topic_increment
        }
        env {
          name  = "GOOGLE_PUBSUB_SUBSCRIPTION_INCREMENT"
          value = var.env_google_pubsub_subscription_increment
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"        = "10"
        "run.googleapis.com/cloudsql-instances"   = var.cloudsql_connection_name
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector
        "run.googleapis.com/vpc-access-egress"    = "private-ranges-only"
      }
    }
  }
  autogenerate_revision_name = true
}
