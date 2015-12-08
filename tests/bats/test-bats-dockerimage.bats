#!/usr/bin/env bats

BATS_VERSION=0.4.0
@test "With no cmd/args, the image return Bats version" {
	docker run -t "${DOCKER_IMAGE_NAME}" | grep "Bats" | grep "${BATS_VERSION}"
}

DEBIAN_VERSION=8.2
@test "We use the debian linux version ${DEBIAN_VERSION}" {
	[ $(docker run --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "grep \"${DEBIAN_VERSION}\" /etc/debian_version | wc -l") -eq 1 ]
}

@test "A sample bats test" {
	# Following Docker docs., hostname is the ID of the current running container by default
	# Since we run bats inside Docker, we have to share a known path to abstract from underlying host
	docker run -t --volumes-from $(hostname) "${DOCKER_IMAGE_NAME}" /app/tests/samples/
}

@test "Bash is installed" {
	docker run --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which bash"
}

@test "Make is installed" {
	docker run --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which make"
}

@test "Curl is installed" {
	docker run --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which curl"
}
