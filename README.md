# Bats Docker image

## Description

That image embed [bats](https://github.com/sstephenson/bats), a bash-testing framework.

The idea is to use Docker's lightweight isolation to have an auto-sufficient image that embed bats and its dependencies, even if it only need bash as dependency...

## Usage

From here, just pre-download the image from the registry :
```
$ docker pull dduportal/bats:0.4.0
# It is strongly recommended to use tags, even if dduportal/bats will work as latest tag is implied
```

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


*TODO*

```
$ cat Dockerfile
```

## Image content and considerations


*TODO*

