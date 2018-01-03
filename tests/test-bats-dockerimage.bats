#!/usr/bin/env bats

BATS_VERSION=0.4.0

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

@test "Environment variable for Bats Helper is set and valid" {
  local CUSTOM_DOCKER_RUN_OPTS="--entrypoint bash"
  run_command_with_docker -c 'test -d "${BATS_HELPERS_DIR}"'
}

@test "ztombol's bats-support helpers is installed" {
  local CUSTOM_DOCKER_RUN_OPTS="--entrypoint bash"
  run_command_with_docker -c 'test -e "${BATS_HELPERS_DIR}/bats-support/load.bash"'
}

@test "ztombol's bats-file helpers is installed" {
  local CUSTOM_DOCKER_RUN_OPTS="--entrypoint bash"
  run_command_with_docker -c 'test -e "${BATS_HELPERS_DIR}/bats-file/load.bash"'
}

@test "ztombol's bats-assert helpers is installed" {
  local CUSTOM_DOCKER_RUN_OPTS="--entrypoint bash"
  run_command_with_docker -c 'test -e "${BATS_HELPERS_DIR}/bats-assert/load.bash"'
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
