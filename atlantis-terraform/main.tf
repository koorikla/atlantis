resource "helm_release" "atlantis" {
  name       = "atlantis"
  chart      = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  namespace  = var.atlantis_namespace
  version    = var.helm_chart_version
  create_namespace = true

  # Use the templatefile function to replace variables in the values.yaml file
  values = [
    templatefile("${path.module}/atlantis-helm-values.yaml", {
      github_user  = var.github_user,
      github_token = var.github_token,
      github_secret = var.github_secret      
    })
  ]
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