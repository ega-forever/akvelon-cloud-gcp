resource "kubernetes_secret" "db_backend_credentials" {
  metadata {
    name = "backend-credentials-db"
  }
  type = "Opaque"
  data = {
    username: var.db_username
    password: var.db_password
    db_host: "127.0.0.1"
    db_port: "5432"
  }
}

resource "kubernetes_secret" "db_proxy_credentials" {
  metadata {
    name = "proxy-credentials-db"
  }
  type = "Opaque"
  data = {
    "credentials.json" = base64decode(var.service_account_db_private_key)
  }
}

resource "kubernetes_secret" "pubsub_credentials" {
  metadata {
    name = "pubsub-credentials"
  }
  type = "Opaque"
  data = {
    "credentials.json" = base64decode(var.service_account_pubsub_private_key)
  }
}