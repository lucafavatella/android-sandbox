.PHONY: all
all: build

DOCKER_IMAGE = eaf36f8f21d3

.PHONY: build
build:
	docker -D -l debug pull $(DOCKER_IMAGE)
	docker -D run -t \
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
