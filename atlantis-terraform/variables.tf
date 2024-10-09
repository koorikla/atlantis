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

variable "github_user" {
  description = "GitHub username"
  type        = string
}

variable "github_token" {
  description = "GitHub token"
  type        = string
  sensitive   = true
}

variable "github_secret" {
  description = "GitHub secret"
  type        = string
  sensitive   = true
}