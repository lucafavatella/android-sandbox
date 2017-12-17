.PHONY: all
all: build

DOCKERFILE_URL = https://github.com/lucafavatella/docker-lineage-cicd.git#review-wip
DOCKER_IMAGE = los-image-wip

.PHONY: docker-image
docker-image:
	docker build -t $(DOCKER_IMAGE) "$(DOCKERFILE_URL)"

.PHONY: build
build:
	docker -D run -t \
		--name low-wip \
		--entrypoint "/bin/sh" \
		-e "USE_CCACHE=1" \
		-e "BRANCH_NAME=cm-14.1" \
		-e "DEVICE_LIST=cedric" \
		-e "DEBUG=true" \
		-e "WITH_SU=false" \
		-v "$(CURDIR)/source:/srv/src" \
		-v "$(CURDIR)/ccache:/srv/ccache" \
		-v "$(CURDIR)/zips:/srv/zips" \
		-v "$(CURDIR)/local_manifests:/srv/local_manifests" \
		$(DOCKER_IMAGE) \
		-c "ccache -M 50G && /root/build.sh"
