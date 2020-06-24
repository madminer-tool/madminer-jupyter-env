DOCKER_NAME=madminer-jupiter-env
DOCKER_REGISTRY=madminertool
DOCKER_VERSION=$(shell cat ./VERSION)


all: build push


.PHONY: build
build:
	@docker build . --tag $(REGISTRY)/$(NAME):$(VERSION) --tag $(REGISTRY)/$(NAME):latest


.PHONY: push
push: build
	@docker login --username "${DOCKERUSER}" --password "${DOCKERPASS}"
	@docker push $(REGISTRY)/$(NAME):$(VERSION)
	@docker push $(REGISTRY)/$(NAME):latest
