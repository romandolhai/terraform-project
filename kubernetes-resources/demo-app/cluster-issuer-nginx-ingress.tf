# Manifest that deploys ClusterIssuer required for letsencrypt

resource "kubernetes_manifest" "clusterissuer_letsencrypt_cluster_issuer" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind" = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt-cluster-issuer"
    }
    "spec" = {
      "acme" = {
        "email" = "roman.dolhai@scaletools.com"
        "privateKeySecretRef" = {
          "name" = "letsencrypt-cluster-issuer-key"
        }
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "solvers" = [
          {
            "http01" = {
              "ingress" = {
                "class" = "nginx"
              }
            }
          },
        ]
      }
    }
  }
}
