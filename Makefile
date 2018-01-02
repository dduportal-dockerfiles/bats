.PHONY: build test all

export DOCKER_IMAGE_NAME ?= dduportal/bats
export BATS_VERSION ?= 0.4.0

all: build test

build:
	docker build \
		--tag $(DOCKER_IMAGE_NAME):$(BATS_VERSION) \
		--build-arg BATS_VERSION=$(BATS_VERSION) \
		./

test:
	docker run \
		-v $(CURDIR):/app \
		-v $$(which docker):$$(which docker) \
		-v /var/run/docker.sock:/docker.sock \
		-e DOCKER_HOST="unix:///docker.sock" \
		-e DOCKER_IMAGE_NAME \
		-e BATS_VERSION \
		$(DOCKER_IMAGE_NAME):$(BATS_VERSION) \
			/app/tests/bats/
