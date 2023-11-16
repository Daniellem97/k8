
resource "kubernetes_namespace" "example" {
  metadata {
    name   = "example-namespace"
    labels = {
      "env" = "test"
    }
  }
}
