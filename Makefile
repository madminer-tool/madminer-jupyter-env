DOCKER_NAME = madminer-jupyter-env
DOCKER_REGISTRY = madminertool
DOCKER_VERSION = $(shell cat VERSION)


.PHONY: build
build:
	@echo "Building Docker image..."
	@docker build . --tag $(DOCKER_REGISTRY)/$(DOCKER_NAME):$(DOCKER_VERSION)


.PHONY: push
push: build
	@echo "Pushing Docker image..."
	@docker login --username "${DOCKERUSER}" --password "${DOCKERPASS}"
	@docker push $(DOCKER_REGISTRY)/$(DOCKER_NAME):$(DOCKER_VERSION)
