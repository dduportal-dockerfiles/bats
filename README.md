# Bats Docker image

## Description

That image embed [bats](https://github.com/bats-core/bats-core),
a bash-testing framework.

The idea is to use Docker's lightweight isolation
to have a self-contained image embedding bats,
any dependency, and all your tests.

[![Build Status](https://travis-ci.org/dduportal-dockerfiles/bats.svg?branch=master)](https://travis-ci.org/dduportal-dockerfiles/bats)

## Usage

Pull the image from the DockerHub registry:

```
docker pull dduportal/bats:0.4.0
```

Then you have 2 usages explained below:

* *Run time execution*: Run your tests with `docker run`
  - It requires mounting a folder inside the container
* *Build time execution*: Build your own image,
by extending this image
  - It requires to have a `docker build` / `docker run` workflow

### Run time execution

* Share your test directory inside the container,
and provide it to bats entrypoint as a `docker run` argument:

```
docker run \
	-v /path/to/the/folder/storing/your/tests:/my-tests \
	dduportal/bats:0.4.0 \
		/my-tests
```

### Build time execution

Build your own Docker image from a custom `Dockerfile`,
extending this base image.

Please check this `Dockerfile` example below:

```
$ cat Dockerfile
FROM dduportal/bats:0.4.0
LABEL Maintainer="<insert your name here>"

COPY ./your-test-directory /tests

# Optional:
RUN apk add --no-cache <your dependencies>

CMD ["/your-test-directory"]
$ docker build -t my-tests ./
...
$ docker run -t my-tests
...
```

## Contributing

Contributions are welcome!
It is based on the free time you have to help:

### I have 1 minute

* Simply an issue describing your challenge/problem/bug,
or the goal you want to achieve

### I have 1 hour

* Open an issue (see "I have 1 minute")
* Ensure you have on your machine:
  - [Docker](https://www.docker.com/),
  - Bash and GNU Make (the command `make`)
  - Git
* Fork this repository
* Clone your fork on your machine
* Write test(s) in `/tests/`
* (Re)Write the Dockerfile
* (Re)Write the documentation if needed
* Run `make all`
* If NOT OK, fix and iterate
* If OK, commit and push
* Finally, open a Pull Request with a link to the issue
you had raised earlier
  - The CI system will automatically build and test for you providing feedback
