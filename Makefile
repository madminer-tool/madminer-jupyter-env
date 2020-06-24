DOCKER_NAME=madminer-jupiter-env
DOCKER_REGISTRY=madminertool
DOCKER_VERSION=$(shell cat ./VERSION)


all: build push


.PHONY: build
build:
	@docker build . \
		--tag $(DOCKER_REGISTRY)/$(DOCKER_NAME):$(DOCKER_VERSION) \
		--tag $(DOCKER_REGISTRY)/$(DOCKER_NAME):latest


.PHONY: push
push: build
	@docker login --username "${DOCKERUSER}" --password "${DOCKERPASS}"
	@docker push $(DOCKER_REGISTRY)/$(DOCKER_NAME):$(DOCKER_VERSION)
	@docker push $(DOCKER_REGISTRY)/$(DOCKER_NAME):latest
