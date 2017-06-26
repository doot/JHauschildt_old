SHELL 						:= /bin/bash -e
LC_ALL						:= C
COMMIT_SHORT ?= $(shell git rev-parse --short HEAD)
APP_NAME					:= jhauschildt
DH_NAME 					:= doot
.DEFAULT_GOAL			:= help
export LC_ALL=C

.PHONY: init test build docker_build docker_test docker_push clean pipeline update_cli help

pipeline: test build docker_build docker_test docker_push

init: ## Initialize project so that it can be built.  Will install angular-cli globally and install npm dependencies locally.
	#ln -i -s scripts/pre-commit .git/hooks/pre-commit
	#above line should no longer be necessary with pre-commit package
	npm install -g @angular/cli@latest
	npm install
	
update_cli: ## Shortcut to update angular-cli to the latest version
	@echo "Updating global angular-cli"
	npm uninstall -g @angular/cli@latest
	npm cache clean
	npm install -g @angular/cli@latest

	@echo "Updating local angular-cli"
	rm -rf node_modules dist tmp
	npm install --save-dev @angular/cli@latest
	npm install
	ng update --routing

test: ## Run linter and tests through PhantomJS
	@echo -e "Linting...\n"
	ng lint
	@echo -e "Running tests...\n"
	ng test --watch false --browsers PhantomJS --no-progress
	@echo -e "Running e2e tests...\n"
	@echo "..."

build: ## Build project for production
	@echo -e "Running build...\n"
	ng build --prod --aot --no-progress

docker_build: ## Build a docker image to serve the dist directory (built by `make build`) to a tar file
	@echo -e "Running docker build...\n"
	@echo COMMIT_SHORT is $(COMMIT_SHORT)
	echo $(COMMIT_SHORT) > dist/build_version
	date "+%Y%m%d%H%M%S" > dist/build_date
	docker build --pull -t $(DH_NAME)/$(APP_NAME):$(COMMIT_SHORT) .
	docker save -o $(APP_NAME)-app.tar $(DH_NAME)/$(APP_NAME):$(COMMIT_SHORT)

docker_test: ## Tests that the docker image file can be loaded and serves a web page
	@echo -e "Loading previously built image ($(APP_NAME)-app.tar) and testing...\n"
	docker load -i $(APP_NAME)-app.tar
	$(eval DID := $(shell docker run -d -p 8080:80 $(DH_NAME)/$(APP_NAME):$(COMMIT_SHORT)))
	sleep 30
	docker logs $(DID)
	curl --retry 10 --retry-delay 5 -v --fail http://localhost:8080

docker_push: ## Deploys docker image file to docker hub tagged with the commit hash.  Only deploys when in the master branch.
	@echo -e "Attempting deploy, if in master... \n"
	@if [ "$$SNAP_BRANCH" == "master" ]; then \
	  echo -e "Detected master branch, pushing to docker hub...\n"; \
	  docker load -i $(APP_NAME)-app.tar; \
	  docker tag $(DH_NAME)/$(APP_NAME):${COMMIT_SHORT} $(DH_NAME)/$(APP_NAME):stable; \
	  docker tag $(DH_NAME)/$(APP_NAME):${COMMIT_SHORT} $(DH_NAME)/$(APP_NAME):latest; \
	  #docker push $(DH_NAME)/$(APP_NAME):stable; \
	  docker push $(DH_NAME)/$(APP_NAME) \
	  #docker push $(DH_NAME)/$(APP_NAME):${COMMIT_SHORT}; \
	else \
	  echo -e "Not on the master branch, won't deploy...\n"; \
	fi;

dev: ## Serves the project in a dev environment, specifically c9.io IDE
	ng serve --port $$C9_PORT --host $$C9_IP --aot --no-progress
	
deploy: ## To be implemented
	# deploy

clean: ## Removes files from the build process such as dist, tmp, and the docker image
	$(RM) -rf dist/
	$(RM) -rf tmp/
	$(RM) $(APP_NAME)-app.tar

help: ## Displays this help message and documentation for each recipe.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
