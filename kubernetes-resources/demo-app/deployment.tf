# Manifest for kubernetes deployment

resource "kubernetes_manifest" "deployment_example_deploy" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "annotations" = {
        "fluxcd.io/automated" = "true"
        "fluxcd.io/tag.example-app" = "semver:~1.0"
      }
      "labels" = {
        "app" = "example-app"
        "test" = "test"
      }
      "name" = "example-deploy"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 2
      "selector" = {
        "matchLabels" = {
          "app" = "example-app"
        }
      }
      "strategy" = {
        "rollingUpdate" = {
          "maxSurge" = 1
          "maxUnavailable" = 0
        }
        "type" = "RollingUpdate"
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "example-app"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "aimvector/python:1.0.4"
              "imagePullPolicy" = "Always"
              "name" = "example-app"
              "ports" = [
                {
                  "containerPort" = 5000
                },
              ]
              "resources" = {
                "limits" = {
                  "cpu" = "500m"
                  "memory" = "256Mi"
                }
                "requests" = {
                  "cpu" = "50m"
                  "memory" = "64Mi"
                }
              }
            },
          ]
          "tolerations" = [
            {
              "effect" = "NoSchedule"
              "key" = "cattle.io/os"
              "value" = "linux"
            },
          ]
        }
      }
    }
  }
}
