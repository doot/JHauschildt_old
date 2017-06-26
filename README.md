# JHauschildt
[![Build Status](https://travis-ci.org/doot/JHauschildt.svg?branch=master)](https://travis-ci.org/doot/JHauschildt)
Mostly doing this to play around with Angular 2, different CI/CD systems, docker, etc...

Placeholder for jhauschildt.com.  It will eventually be a real webpage...

## Setup/Build

``` bash
# Setup
make init

# Run in c9.io
make dev

# Run tests and linter
make test

# Build for production and deploy to docker hub
make test
make build
make docker_build
make docker_test
make docker_push

```

make help:
```
build                Build project for production
clean                Removes files from the build process such as dist, tmp, and the docker image
deploy               To be implemented
dev                  Serves the project in a dev environment, specifically c9.io IDE
docker_build         Build a docker image to serve the dist directory (built by `make build`) to a tar file
docker_push          Deploys docker image file to docker hub tagged with the commit hash.  Only deploys when in the master branch.
docker_test          Tests that the docker image file can be loaded and serves a web page
help                 Displays this help message
init                 Initialize project so that it can be built.  Will install angular-cli globally and install npm dependencies locally.
test                 Run linter and tests through PhantomJS
update_cli           Shortcut to update angular-cli to the latest version
```
