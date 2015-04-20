#!/usr/bin/env bats

@test "With no cmd/args, the image return Bats version" {
	run docker run -t "${DOCKER_IMAGE_NAME}"
	[ "$status" -eq 0 ]
	[ "${output:0:4}" == "Bats" ]
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