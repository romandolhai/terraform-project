# create namespace for cert mananger
resource "kubernetes_namespace" "cert_manager" {
  metadata {
    labels = {
      "name" = "cert-manager"
    }
    name = "cert-manager"
  }
}
# Install cert-manager helm chart using terraform
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.12.3"
  namespace  = kubernetes_namespace.cert_manager.metadata.0.name
  set {
    name  = "installCRDs"
    value = "true"
  }
  set {
    name  = "webhook.securePort"
    value = "10260"
  }
  depends_on = [
    kubernetes_namespace.cert_manager
  ]
}