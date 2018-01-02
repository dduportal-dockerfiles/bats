.PHONY: build test deploy all

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
		--rm \
		-v $(CURDIR):/app \
		-v $$(which docker):$$(which docker) \
		-v /var/run/docker.sock:/docker.sock \
		-e DOCKER_HOST="unix:///docker.sock" \
		-e DOCKER_IMAGE_NAME \
		-e BATS_VERSION \
		$(DOCKER_IMAGE_NAME):$(BATS_VERSION) \
			/app/tests/

deploy:
	curl -H "Content-Type: application/json" \
		--data '{"source_type": "Branch", "source_name": "$(CURRENT_GIT_BRANCH)"}' \
		-X POST https://registry.hub.docker.com/u/dduportal/bats/trigger/$(DOCKER_HUB_TOKEN)/
