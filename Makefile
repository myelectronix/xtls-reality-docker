export XTLS_VERSION=1.8.3
export DOCKER_REPO="myelectronix/xtls-reality"


.PHONY: build build-local

all: build-local

build-release:
	@echo "Making production version ${XTLS_VERSION} of XTLS-reality proxy server"
	docker build -t "${DOCKER_REPO}:${XTLS_VERSION}" -t "${DOCKER_REPO}:latest" . --no-cache
	docker push "${DOCKER_REPO}:${XTLS_VERSION}"
	docker push "${DOCKER_REPO}:latest"

build-local:
	@echo "Making version of XTLS-reality proxy server for testing on local machine"
	docker build -t "${DOCKER_REPO}:local" . --no-cache