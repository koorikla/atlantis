# Kubernetes provider using the in-cluster service account
provider "kubernetes" {
  host                   = "https://${var.kubernetes_host}"
  token                  = file("/var/run/secrets/kubernetes.io/serviceaccount/token")
  cluster_ca_certificate = file("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")
}

# Helm provider using the in-cluster Kubernetes access
provider "helm" {
  kubernetes {
    host                   = "https://${var.kubernetes_host}"
    token                  = file("/var/run/secrets/kubernetes.io/serviceaccount/token")
    cluster_ca_certificate = file("/var/run/secrets/kubernetes.io/serviceaccount/ca.crt")
  }
}
