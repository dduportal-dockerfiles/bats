# Bats Docker image

## Description

That image embed [bats](https://github.com/sstephenson/bats), a bash-testing framework.

The idea is to use Docker's lightweight isolation to have an auto-sufficient image that embed bats and its dependencies, even if it only need bash as dependency...

[![CircleCi Build Status](https://circleci.com/gh/dduportal-dockerfiles/bats.svg?&style=shield&circle-token=a7fd546c08f8c0a1bf0ff211b07d14f204e65be1)](https://circleci.com/gh/dduportal-dockerfiles/bats)

## Usage

From here, just pre-download the image from the registry :

```
$ docker pull dduportal/bats:0.4.0
```

It is strongly recommended to use tags, even if dduportal/bats will work as latest tag is implied.

Then you have to choices : running directly your test or build your own, which enable you to embed your tests.

### Inline run

You just have to share your bats' tests directory inside the container and provide it to bats entrypoint as ```docker run``` argument :

```
$ docker run \
	-v /path/to/the/folder/storing/your/tests:/my-tests \
	dduportal/bats:0.4.0 \
		/my-tests
```

### Build your own testing image

The goal here is to embed to tests in order to version them or share them, and providing the 'all-in-one' box (e.g. bats + deps. + your tests) as a Docker image artefact :


```
$ cat Dockerfile
FROM dduportal/bats:0.4.0
MAINTAINER <your name>
ADD ./your-tests /app/bats-tests
RUN apk install --update <your dependencies>
CMD ["/app/bats-tests/"]
$ docker build -t my-tests ./
...
$ docker run -t my-tests
...
```

## Image content and considerations

### Base image

This image is built upom debian image, to have a balance beetween size and customization.
It also avoid aving sendfile caching bug when using with virtualbox (default boot2docker hypervisor) shared folder (See https://www.virtualbox.org/ticket/12597 )

### Already installed package

We embed a set of basic packages :
* bash : It's a bats dependency,
* make : since I use Makefile for building and testing my Docker images,
* curl (and ca-certificates): because the default embeded wget does not handle HTTPS 

## Contributing

Do not hesitate to contribute by forking this repository

Pick at least one :

* Implement tests in ```/tests/bats/```

* Write the Dockerfile

* (Re)Write the documentation corrections


Finnaly, open the Pull Request : CircleCi will automatically build and test for you
