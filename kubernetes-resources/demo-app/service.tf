resource "kubernetes_manifest" "service_example_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "example-app"
      }
      "name" = "example-service"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "http"
          "port" = 80
          "protocol" = "TCP"
          "targetPort" = 5000
        },
      ]
      "selector" = {
        "app" = "example-app"
      }
      "type" = "LoadBalancer"
    }
  }
}
