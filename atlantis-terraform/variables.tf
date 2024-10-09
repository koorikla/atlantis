variable "atlantis_namespace" {
  description = "The namespace where Atlantis will be deployed"
  type        = string
  default     = "atlantis"
}

variable "helm_chart_version" {
  description = "Version of the Atlantis Helm chart"
  type        = string
  default     = "5.6.0"
}
