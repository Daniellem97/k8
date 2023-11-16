provider "kubernetes" {
  // Configuration for the Kubernetes provider
  // This is intentionally minimal for planning purposes
}

resource "kubernetes_namespace" "example" {
  metadata {
    name   = "example-namespace"
    labels = {
      "env" = "test"
    }
  }
}
