KIND_CLUSTER_NAME := my-cluster
KIND_CONFIG_FILE := kind-config.yaml


# Dependency check function for osx
dependencies:
	@which brew > /dev/null || (echo "Homebrew not installed. Please install Homebrew first." && exit 1)
	@which kind > /dev/null || brew install kind
	@which helm > /dev/null || brew install helm
	@which kubectl > /dev/null || brew install kubectl
	@which terraform > /dev/null || brew install terraform
	@which docker > /dev/null || brew install --cask docker
	@docker info > /dev/null 2>&1 || (echo "Docker is not running. Please start Docker." && exit 1)
	@helm repo add atlantis https://runatlantis.github.io/helm-charts
	@helm repo update



# Create a Kind cluster
create-cluster:
	kind create cluster --name $(KIND_CLUSTER_NAME) --config $(KIND_CONFIG_FILE)

# Delete a Kind cluster
delete-cluster:
	kind delete cluster --name $(KIND_CLUSTER_NAME)


# Initialize Te
bootstrap-atlantis:
	cd atlantis-terraform && terraform init && terraform apply -auto-approve