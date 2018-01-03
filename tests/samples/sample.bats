#!/usr/bin/env bats

load "${BATS_HELPERS_DIR}/bats-support/load.bash"
load "${BATS_HELPERS_DIR}/bats-file/load.bash"
load "${BATS_HELPERS_DIR}/bats-assert/load.bash"

@test "Simple echo test" {
	echo "Hello Bats"
}

@test "I can use an assert() from helper bats-assert" {
  touch '/var/log/test.log'
  assert [ -e '/var/log/test.log' ]
}

@test "I can use an assert_file_exist() from helper bats-file" {
  assert_file_exist '/tmp'
}
