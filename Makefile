SHELL := /bin/bash -e
LC_ALL := C
SNAP_COMMIT_SHORT ?= $(shell git rev-parse --short HEAD)
APP_NAME := jhauschildt
DH_NAME := doot

.PHONY: init test build docker_build docker_test docker_push clean pipeline update_cli

pipeline: test build docker_build docker_test

init:
	#ln -i -s scripts/pre-commit .git/hooks/pre-commit
	#above line should no longer be necessary with pre-commit package
	npm install -g angular-cli
	npm install
	
update_cli:
	@echo "Updating global angular-cli"
	npm uninstall -g angular-cli
	npm cache clean
	npm install -g angular-cli@latest
	
	@echo "Updating local angular-cli"
	rm -rf node_modules dist tmp
	npm install --save-dev angular-cli@latest
	npm install
	ng init --routing

test:
	@echo -e "Linting...\n"
	ng lint
	@echo -e "Running tests...\n"
	ng test --watch false --browsers PhantomJS --no-progress
	@echo -e "Running e2e tests...\n"
	@echo "..."

build:
	@echo -e "Running build...\n"
	ng build --prod --aot --no-progress

docker_build:
	@echo -e "Running docker build...\n"
	@echo SNAP_COMMIT_SHORT is $(SNAP_COMMIT_SHORT)
	docker build --pull -t $(DH_NAME)/$(APP_NAME):$(SNAP_COMMIT_SHORT) .
	docker save -o $(APP_NAME)-app.tar $(DH_NAME)/$(APP_NAME):$(SNAP_COMMIT_SHORT)

docker_test:
	@echo -e "Loading previously built image ($(APP_NAME)-app.tar) and testing...\n"
	docker load -i $(APP_NAME)-app.tar
	DID=$(shell docker run -d -p 8080:80 $(DH_NAME)/$(APP_NAME))
	sleep 30
	docker logs $(DID)
	curl --retry 10 --retry-delay 5 -v --fail http://localhost:8080

docker_push:
	@echo -e "Attempting deploy, if in master... \n"
	@if [ "$$SNAP_BRANCH" == "master" ]; then \
	  echo -e "Detected master branch, pushing to docker hub...\n"; \
	  docker load -i $(APP_NAME)-app.tar; \
	  docker tag $(DH_NAME)/$(APP_NAME):${SNAP_COMMIT_SHORT} $(DH_NAME)/$(APP_NAME):stable; \
	  docker push $(DH_NAME)/$(APP_NAME):stable; \
	  docker push $(DH_NAME)/$(APP_NAME):${SNAP_COMMIT_SHORT}; \
	else \
	  echo -e "Not on the master branch, won't deploy...\n"; \
	fi;

dev:
	ng serve --port $$C9_PORT --host $$C9_IP --aot --no-progress
	
deploy:
	# deploy

clean:
	$(RM) -rf dist/
	$(RM) -rf tmp/
	$(RM) $(APP_NAME)-app.tar