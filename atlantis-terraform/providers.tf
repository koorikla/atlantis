provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Path to your kube config
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
