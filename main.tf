resource "kubernetes_deployment" "test" {
  metadata {
    name      = "test-deployment"
    namespace = kubernetes_namespace.example.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "demo"
      }
    }

    template {
      metadata {
        labels = {
          app = "demo"
        }
      }

      spec {
        container {
          image = "nonexistent-image:latest"  # This image does not exist
          name  = "demo"
        }
      }
    }
  }

  timeouts {
    create = "10m"
    delete = "10m"
    update = "20m"
  }
}
