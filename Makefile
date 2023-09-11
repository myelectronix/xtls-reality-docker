export XTLS_VERSION=1.8.4
export DOCKER_REPO="myelectronix/xtls-reality"


.PHONY: build build-local build-and-run-local

all: build-and-run-local

build-release:
	@echo "Making production version ${XTLS_VERSION} of XTLS-reality proxy server"
	docker build -t "${DOCKER_REPO}:${XTLS_VERSION}" -t "${DOCKER_REPO}:latest" . --no-cache
	docker push "${DOCKER_REPO}:${XTLS_VERSION}"
	docker push "${DOCKER_REPO}:latest"

build-local:
	@echo "Making version of XTLS-reality proxy server for testing on local machine"
	docker build -t "${DOCKER_REPO}:local" . --no-cache

build-and-run-local:
	@echo "Making version of XTLS-reality proxy server for testing on local machine"
	@if docker ps | grep xtls-reality ; then\
		docker rm --force xtls-reality ;\
	fi
	docker build -t "${DOCKER_REPO}:local" . --no-cache
	docker run -d --rm --name xtls-reality -p 443:443 -v xtls-reality-volume:/opt/xray/config ${DOCKER_REPO}:local