#!/usr/bin/env bats

# load "${BATS_LIBS}/bats-support/load.bash"
# load "${BATS_LIBS}/bats-assert/load.bash"

@test "With no cmd/args, the image return Bats version" {
	docker run -t "${DOCKER_IMAGE_NAME}" | grep "Bats" | grep "${BATS_VERSION}"
}

OS_VERSION=3.7
@test "Base OS is Alpine Linux v${OS_VERSION}" {
	[ $(docker run --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "grep -c \"${OS_VERSION}\" /etc/os-release") -eq 1 ]
}

@test "A sample bats test" {
	# Following Docker docs., hostname is the ID of the current running container by default
	# Since we run bats inside Docker, we have to share a known path to abstract from underlying host
	docker run -t --volumes-from $(hostname) "${DOCKER_IMAGE_NAME}" /app/tests/samples/
}

@test "Bash is installed" {
	docker run --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which bash"
}

@test "Curl is installed" {
	docker run --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which curl"
}
