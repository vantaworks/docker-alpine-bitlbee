FROM alpine:latest
LABEL maintainer=h4110w33n

ADD . /src/bitlbee-plugins

RUN set -x \
	&& apk update \
	&& apk upgrade \
	&& apk add --virtual build-dependencies \
		autoconf \
		automake \
		build-base \
		curl \
		git \
		json-glib-dev \
		libtool \
		mercurial \
		discount-dev \
	&& apk add --virtual runtime-dependencies \
		glib-dev \
		gnutls-dev \
		python3-dev \
		json-glib \
		libotr-dev \
		libgcrypt-dev \
		libpurple \
		libwebp-dev \
		pidgin-dev \
		protobuf-c-dev \
		ca-certificates \
	&& cd /src/bitlbee-plugins \
	&& make all \
	&& apk del --purge build-dependencies \
	&& adduser -u 1000 -S bitlbee \
	&& addgroup -g 1000 -S bitlbee \
	&& chown -R bitlbee:bitlbee /opt/bitlbee-data \
	&& touch /var/run/bitlbee.pid \
	&& chown bitlbee:bitlbee /var/run/bitlbee.pid \
	&& exit 0

USER bitlbee
VOLUME /opt/bitlbee-data
ENTRYPOINT ["/usr/local/sbin/bitlbee", "-F", "-n", "-d", "/opt/bitlbee-data"]
