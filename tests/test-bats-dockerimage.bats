#!/usr/bin/env bats

# load "${BATS_LIBS}/bats-support/load.bash"
# load "${BATS_LIBS}/bats-assert/load.bash"

@test "With no cmd/args, the image return Bats version" {
	docker run --rm -t "${DOCKER_IMAGE_NAME}" | grep "Bats" | grep "${BATS_VERSION}"
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
