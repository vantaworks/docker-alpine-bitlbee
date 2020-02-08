CONTAINER_NAME ?= $(shell basename -s .git `git config --get remote.origin.url`)

.PHONY: all
all: clean dist

.PHONY: kill
kill:
	@docker kill ${CONTAINER_NAME} || echo no container to remove && true

.PHONY: rm
rm:
	@docker rm ${CONTAINER_NAME} || echo no container to remove && true

.PHONY: clean
clean: rm kill
	@docker image rm ${CONTAINER_NAME} || echo no image to remove && true

.PHONY: dist
dist: clean
	docker build -t ${CONTAINER_NAME} . \
	  --build-arg BUILD_TYPE="nightly" \
	  --build-arg BITLBEE_TAG="master" \
	  --build-arg DISCORD_ENABLED=1 \
	  --build-arg FACEBOOK_ENABLED=1 \
	  --build-arg SKYPEWEB_ENABLED=1 \
	  --build-arg SLACK_ENABLED=1 \
	  --build-arg HANGOUTS_ENABLED=1 \
	  --build-arg STEAM_ENABLED=1 \
	  --build-arg TELEGRAM_ENABLED=1 \
	  --build-arg SIPE_ENABLED=1 \
	  --build-arg ROCKETCHAT_ENABLED=1 \
	  --build-arg MATRIX_ENABLED=1 \
	  --build-arg MATTERMOST_ENABLED=1 \
	  --build-arg MASTODON_ENABLED=1 \
	  --build-arg SIGNAL_ENABLED=1

.PHONY: run
run: info
	docker run -d --name ${CONTAINER_NAME} ${CONTAINER_NAME}

.PHONY: shell
shell:
	docker exec -it ${CONTAINER_NAME} /bin/bash

.PHONY: docker-webhook
docker-webhook:
	curl -X POST https://hub.docker.com/api/build/v1/source/${DOCKER_WEBHOOK_SOURCE}/trigger/${DOCKER_WEBHOOK_TRIGGER}/call/
