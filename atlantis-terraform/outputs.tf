output "atlantis_url" {
  value = "kubectl port-forward -n atlantis atlantis-0 4141:4141  and open in browser  http://localhost:4141"
  description = "The URL to access Atlantis service locally"
}


output "atlantis_external_url" {
  value = "kubectl logs deployment/cloudflared | grep 'INF |  https://'"
  description = "The URL to access Atlantis service externally"
}
