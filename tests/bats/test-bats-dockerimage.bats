#!/usr/bin/env bats

BATS_VERSION=0.4.0
@test "With no cmd/args, the image return Bats version" {
	run docker run -t "${DOCKER_IMAGE_NAME}"
	[ "$status" -eq 0 ]
	[ "${output:0:4}" == "Bats" ]
}

ALPINE_VERSION=3.2
@test "We use the alpine linux version ${ALPINE_VERSION}" {
	[ $(docker run --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "grep VERSION_ID /etc/os-release | grep -e \"=${ALPINE_VERSION}.\" | wc -l") -eq 1 ]
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