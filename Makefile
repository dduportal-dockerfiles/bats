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
	bats $(CURDIR)/tests/

deploy:
	curl -H "Content-Type: application/json" \
		--data '{"source_type": "Branch", "source_name": "$(CURRENT_GIT_BRANCH)"}' \
		-X POST https://registry.hub.docker.com/u/dduportal/bats/trigger/$(DOCKER_HUB_TOKEN)/
