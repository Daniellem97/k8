resource "kubernetes_deployment" "test-read" {
  metadata {
    name = "test-read"
    labels = {
      app = "test-read"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "test-read"
      }
    }

    template {
      metadata {
        labels = {
          app = "test-read"
        }
      }

      spec {
        container {
          image = "busybox"
          name  = "test-read"
          command = ["sleep", "1000"]  // Change command to keep the container running

          readinessProbe {
            http_get {
              path = "/nonexistent"  // Intentionally failing readiness probe
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds         = 5
          }
        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_unavailable = "0"
        max_surge       = "1"
      }
    }
  }
}
