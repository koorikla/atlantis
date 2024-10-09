variable "kubernetes_host" {
  description = "The API server URL of the Kubernetes cluster"
  default     = "https://kubernetes.default.svc" # This is the default for in-cluster communication
}