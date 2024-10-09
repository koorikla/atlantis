resource "helm_release" "atlantis" {
  name       = "atlantis"
  chart      = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  namespace  = var.atlantis_namespace
  version    = var.helm_chart_version
  create_namespace = true

  # Point to the helm-values.yaml file for configuration
  values = [file("${path.module}/atlantis-helm-values.yaml")]
}

# Deployment to create a cloudflare tunnel
resource "kubernetes_deployment" "cloudflared" {
  metadata {
    name      = "cloudflared"
    namespace = "default"
    labels = {
      app = "cloudflared"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "cloudflared"
      }
    }
    template {
      metadata {
        labels = {
          app = "cloudflared"
        }
      }
      spec {
        container {
          name  = "cloudflared"
          image = "cloudflare/cloudflared:latest"
          args  = ["tunnel", "--url", "http://atlantis.atlantis.svc.cluster.local"]

          resources {
            limits = {
              memory = "256Mi"
              cpu    = "200m"
            }
            requests = {
              memory = "128Mi"
              cpu    = "100m"
            }
          }
        }
      }
    }
  }
}