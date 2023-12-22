resource "kubernetes_manifest" "certificate_example_app" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind" = "Certificate"
    "metadata" = {
      "name" = "example-app"
      "namespace" = "default"
    }
    "spec" = {
      "dnsNames" = [
        "demoapp.scaletools.com.ua",
      ]
      "issuerRef" = {
        "kind" = "ClusterIssuer"
        "name" = "letsencrypt-cluster-issuer"
      }
      "secretName" = "example-app-tls"
    }
  }
}
