resource "kubernetes_namespace" "example" {
  metadata {
    name   = "example-namespace"
    labels = {
      "env" = "test"
    }
  }
}

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
          image = "nonexistent-image:latest" # This image does not exist
          name  = "demo"

          # Adding a command that exits with error to ensure failure
          command = ["sh", "-c", "exit 1"]
        }
      }
    }
  }
}
