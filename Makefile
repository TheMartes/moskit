MIN_MAKE_VERSION := 3.81

# Min version
ifneq ($(MIN_MAKE_VERSION),$(firstword $(sort $(MAKE_VERSION) $(MIN_MAKE_VERSION))))
	$(error GNU Make $(MIN_MAKE_VERSION) or higher required)
endif

.DEFAULT_GOAL:=help

##@ Development
.PHONY: build
build: ## Build the artillery
	docker build --target bin --output bin/ --platform local .

enable-docker-buildkit: ## Enables Integrated docker build kit
	export DOCKER_BUILDKIT=1

disable-docker-buildkit: ## Disables Integrated docker build kit
	export DOCKER_BUILDKIT=0

##@ Help
.PHONY: help
help: ## Show all available commands (you are looking at it)
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
