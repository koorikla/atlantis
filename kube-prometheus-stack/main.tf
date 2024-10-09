resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "65.1.1"

  values = [
    file("${path.module}/helm-values.yaml")
  ]
}

# Loki log database
resource "helm_release" "loki" {
  name       = "loki"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = "5.0.0"  # Update to the latest version if needed

  values = [
    <<EOF
    persistence:
      enabled: true
      size: 10Gi
    EOF
  ]
}

# Promtail log scraper
resource "helm_release" "promtail" {
  name       = "promtail"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version    = "5.0.0"  # Update to the latest version if needed

  values = [
    <<EOF
    loki:
      service:
        name: loki
        port: 3100
    EOF
  ]
}

# Tempo for Traces
resource "helm_release" "tempo" {
  name       = "tempo"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "tempo"
  version    = "1.5.0"  # Update to the latest version if needed

  values = [
    <<EOF
    persistence:
      enabled: true
      size: 10Gi
    compactor:
      enabled: true
    query_frontend:
      enabled: true
    EOF
  ]
}