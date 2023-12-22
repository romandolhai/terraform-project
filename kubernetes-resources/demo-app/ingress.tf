# Manifest that apply ingress rule for app

resource "kubernetes_manifest" "ingress_example_app" {
  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind" = "Ingress"
    "metadata" = {
      "annotations" = {
        "kubernetes.io/ingress.class" = "nginx"
      }
      "name" = "example-app"
      "namespace" = "default"
    }
    "spec" = {
      "rules" = [
        {
          "host" = "demoapp.scaletools.com.ua"
          "http" = {
            "paths" = [
              {
                "backend" = {
                  "service" = {
                    "name" = "example-service"
                    "port" = {
                      "number" = 80
                    }
                  }
                }
                "path" = "/"
                "pathType" = "Prefix"
              },
            ]
          }
        },
      ]
      "tls" = [
        {
          "hosts" = [
            "demoapp.scaletools.com.ua",
          ]
          "secretName" = "example-app-tls"
        },
      ]
    }
  }
}
