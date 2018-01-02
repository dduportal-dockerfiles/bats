#!/usr/bin/env bats

# load "${BATS_LIBS}/bats-support/load.bash"
# load "${BATS_LIBS}/bats-assert/load.bash"

run_command_with_docker() {
  docker run --rm -t ${CUSTOM_DOCKER_RUN_OPTS} \
    "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" "$@"
}

setup() {
  export CUSTOM_DOCKER_RUN_OPTS=""
}

@test "With no cmd/args, the image return Bats version" {
	run_command_with_docker | grep "Bats" | grep "${BATS_VERSION}"
}

@test "Base OS is using Alpine Linux" {
  local CUSTOM_DOCKER_RUN_OPTS="--entrypoint grep"
  run_command_with_docker "Alpine" /etc/os-release
}

@test "We can run a sample test at run time by mounting it" {
  local CUSTOM_DOCKER_RUN_OPTS="-v $(pwd)/sample:/tests"
	run_command_with_docker /tests/
}

@test "Bash is installed" {
  local CUSTOM_DOCKER_RUN_OPTS="--entrypoint which"
	run_command_with_docker bash
}

@test "Curl is installed" {
  local CUSTOM_DOCKER_RUN_OPTS="--entrypoint which"
	run_command_with_docker curl
}
