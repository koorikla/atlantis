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


bootstrap-atlantis:
	@read -p "Enter your GitHub username: " github_user; \
	read -sp "Enter your GitHub token: " github_token; \
	echo ""; \
	read -sp "Enter your GitHub secret: " github_secret; \
	echo ""; \
	export TF_VAR_github_user=$$github_user; \
	export TF_VAR_github_token=$$github_token; \
	export TF_VAR_github_secret=$$github_secret; \
	cd atlantis-terraform && terraform init && terraform apply -auto-approve