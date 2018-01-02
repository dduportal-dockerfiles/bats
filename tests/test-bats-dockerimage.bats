#!/usr/bin/env bats

# load "${BATS_LIBS}/bats-support/load.bash"
# load "${BATS_LIBS}/bats-assert/load.bash"

CUSTOM_DOCKER_RUN_OPTS=""

run_command_with_docker() {
  docker run --rm -t ${CUSTOM_DOCKER_RUN_OPTS} \
    "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" "$@"
}

@test "With no cmd/args, the image return Bats version" {
	run_command_with_docker | grep "Bats" | grep "${BATS_VERSION}"
}

OS_VERSION=3.7
@test "Base OS is Alpine Linux v${OS_VERSION}" {
  docker run --entrypoint grep --rm -t "${DOCKER_IMAGE_NAME}" "Alpine" /etc/os-release
  docker run --entrypoint grep --rm -t "${DOCKER_IMAGE_NAME}" "${OS_VERSION}" /etc/os-release
}

@test "We can run a sample test at run time by mounting it" {
	docker run --rm -t -v $(pwd)/sample:/tests "${DOCKER_IMAGE_NAME}" /tests/
}

@test "Bash is installed" {
	docker run --rm  --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which bash"
}

@test "Curl is installed" {
	docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which curl"
}
