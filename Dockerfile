FROM alpine:latest
LABEL maintainer=h4110w33n@gmail.com

# Globals
ARG BUILD_TYPE="nightly"
ARG BUILD_DATE
ARG UID=1000
ARG GID=1000
LABEL build_version="Bitlbee w/Plugins (Vanta.works) - ${BUILD_TYPE}"

###########
# BITLBEE #
###########
ARG BITLBEE_TAG=master
RUN addgroup -g ${GID} -S bitlbee && \
    adduser -u ${UID} -D -S -G bitlbee bitlbee && \
    apk add --no-cache --update --virtual bitlbee-runtime-deps \
        gnutls \
        libgcrypt \
 	    tzdata \
	    bash \
	    glib \
	    curl \
	    libpurple \
	    libpurple-xmpp \
	    libpurple-oscar \
	    libpurple-bonjour && \
	apk add --no-cache --update --virtual bitlbee-build-deps \
	    build-base \
	    git \
	    glib-dev \
	    gnutls-dev \
	    libgcrypt-dev \
	    python2 \
	    pidgin-dev && \
	cd /tmp && \
	git clone -n https://github.com/bitlbee/bitlbee.git && \
	cd bitlbee && \
	git checkout ${BITLBEE_TAG} && \
	./configure \
	    --build=x86_64-alpine-linux-musl \
	    --host=x86_64-alpine-linux-musl \
	    --purple=1 \
	    --ssl=gnutls \
	    --prefix=/usr \
	    --etcdir=/etc/bitlbee \
	    --pidfile=/var/run/bitlbee/bitlbee.pid &&\
	make && \
	make install && \
	make install-dev && \
	make install-etc && \
	strip /usr/sbin/bitlbee && \
	rm -rf /tmp/* && \
	mkdir -p /var/lib/bitlbee/ && \
    chown bitlbee:bitlbee /var/lib/bitlbee && \
    mkdir -p /var/run/bitlbee/ && \
    chown bitlbee:bitlbee /var/run/bitlbee && \
	apk del bitlbee-build-deps

###########
# DISCORD #
###########
ARG DISCORD_ENABLED=1
ARG DISCORD_TAG=master
RUN if [ ${DISCORD_ENABLED} -eq 1 ]; then cd /tmp && \
    apk add --no-cache --update --virtual discord-build-deps \
	    build-base \
	    git \
	    autoconf \
	    automake \
	    libtool \
	    glib-dev && \
	git clone -n https://github.com/sm00th/bitlbee-discord.git && \
	cd bitlbee-discord && \
	git checkout ${DISCORD_VERSION} && \
	./autogen.sh && \
	./configure \
	    --build=x86_64-alpine-linux-musl \
	    --host=x86_64-alpine-linux-musl \
	    --prefix=/usr && \
	make && \
	make install && \
	strip /usr/lib/bitlbee/discord.so && \
	rm -rf /tmp/* && \
	apk del discord-build-deps; fi

############
# Facebook #
############
ARG FACEBOOK_ENABLED=1
ARG FACEBOOK_TAG=master
RUN if [ ${FACEBOOK_ENABLED} -eq 1 ]; then cd /tmp && \
    apk add --no-cache --update --virtual facebook-run-deps \
	    json-glib && \
	apk add --no-cache --update --virtual facebook-build-deps \
	    build-base \
	    git \
	    autoconf \
	    automake \
	    libtool \
	    glib-dev \
	    json-glib-dev && \
	git clone -n https://github.com/bitlbee/bitlbee-facebook.git && \
	cd bitlbee-facebook && \
	git checkout ${FACEBOOK_TAG} && \
	./autogen.sh \
	    --build=x86_64-alpine-linux-musl \
	    --host=x86_64-alpine-linux-musl && \
	make && \
	make install && \
	strip /usr/lib/bitlbee/facebook.so && \
	rm -rf /tmp/* && \
	apk del facebook-build-deps; fi

#########
# Skype #
#########
ARG SKYPEWEB_ENABLED=1
ARG SKYPEWEB_TAG=master
RUN if [ ${SKYPEWEB_ENABLED} -eq 1 ]; then cd /tmp && \
    apk add --no-cache --update --virtual skypeweb-run-deps \
	    json-glib && \
	apk add --no-cache --update --virtual skypeweb-build-deps \
	    build-base \
	    git \
	    pidgin-dev \
	    json-glib-dev && \
	git clone -n https://github.com/EionRobb/skype4pidgin.git && \
	cd skype4pidgin && \
	git checkout ${SKYPEWEB_TAG} && \
	cd skypeweb && \
	make && \
	make install && \
	strip /usr/lib/purple-2/libskypeweb.so && \
	rm -rf /tmp/* && \
	apk del skypeweb-build-deps; fi

#########
# Slack #
#########
ARG SLACK_ENABLED=1
ARG SLACK_TAG=master
RUN if [ ${SLACK_ENABLED} -eq 1 ]; then cd /tmp && \
    apk add --no-cache --update --virtual slack-build-deps \
	    build-base \
	    git \
	    pidgin-dev \
	    glib-dev && \
	git clone -n https://github.com/dylex/slack-libpurple.git && \
	cd slack-libpurple && \
	git checkout ${SLACK_TAG} && \
	make && \
	make install && \
	strip /usr/lib/purple-2/libslack.so && \
	rm -rf /tmp/* && \
	apk del slack-build-deps; fi

##############
# Mattermost #
##############
ARG MATTERMOST_ENABLED=1
ARG MATTERMOST_TAG=master
RUN if [ ${MATTERMOST_ENABLED} -eq 1 ]; then cd /tmp && \
    apk add --no-cache --update --virtual mattermost-run-deps \
	    json-glib && \
    apk add --no-cache --update --virtual mattermost-build-deps \
	    build-base \
	    discount-dev \
	    git \
	    pidgin-dev \
	    glib-dev \
	    json-glib-dev && \
	git clone -n https://github.com/EionRobb/purple-mattermost.git && \
	cd purple-mattermost && \
	git checkout ${MATTERMOST_TAG} && \
	make && \
	make install && \
	strip /usr/lib/purple-2/libmattermost.so && \
	rm -rf /tmp/* && \
	apk del mattermost-build-deps; fi

############
# Hangouts #
############
ARG HANGOUTS_ENABLED=1
ARG HANGOUTS_TAG=master
RUN if [ ${HANGOUTS_ENABLED} -eq 1 ]; then cd /tmp && \
    apk add --no-cache --update --virtual hangouts-run-deps \
	    protobuf-c \
	    json-glib && \
	apk add --no-cache --update --virtual hangouts-build-deps \
	    git \
	    build-base \
	    pidgin-dev \
	    protobuf-c-dev \
	    json-glib-dev && \
	git clone https://github.com/EionRobb/purple-hangouts.git && \
	cd purple-hangouts && \
	git checkout ${HANGOUTS_TAG} && \
	make && \
	make install && \
	strip /usr/lib/purple-2/libhangouts.so && \
	rm -rf /tmp/* && \
	apk del hangouts-build-deps; fi

#########
# Steam #
#########
ARG STEAM_ENABLED=1
ARG STEAM_TAG=master
RUN if [ ${STEAM_ENABLED} -eq 1 ]; then cd /tmp && \
    apk add --no-cache --update --virtual steam-run-deps \
	    libgcrypt && \
	apk add --no-cache --update --virtual steam-build-deps \
	    build-base \
	    git \
	    autoconf \
	    automake \
	    libtool \
	    libgcrypt-dev \
	    glib-dev && \
	git clone -n https://github.com/bitlbee/bitlbee-steam.git && \
	cd bitlbee-steam && \
	git checkout ${STEAM_TAG} && \
	./autogen.sh \
	    --build=x86_64-alpine-linux-musl \
	    --host=x86_64-alpine-linux-musl && \
	make && \
	make install && \
	strip /usr/lib/bitlbee/steam.so && \
	rm -rf /tmp/* && \
	apk del steam-build-deps; fi

############
# Telegram #
############
ARG TELEGRAM_ENABLED=1
ARG TELEGRAM_TAG=master
RUN if [ ${TELEGRAM_ENABLED} -eq 1 ]; then cd /tmp && \
    apk add --no-cache --update --virtual telegram-run-deps \
	    libgcrypt \
	    zlib \
	    libwebp \
	    libpng && \
	apk add --no-cache --update --virtual telegram-build-deps \
	    build-base \
	    git \
	    libgcrypt-dev \
	    zlib-dev \
	    pidgin-dev \
	    libwebp-dev \
	    libpng-dev && \
	git clone -n https://github.com/majn/telegram-purple && \
	cd telegram-purple && \
	git checkout ${TELEGRAM_TAG} && \
	git submodule update --init --recursive && \
	./configure \
	    --build=x86_64-alpine-linux-musl \
	    --host=x86_64-alpine-linux-musl && \
	make && \
	make install && \
	strip /usr/lib/purple-2/telegram-purple.so && \
	rm -rf /tmp/* && \
	apk del telegram-build-deps; fi

########
# SIPE #
########
ARG SIPE_ENABLED=1
ARG SIPE_TAG=launchpad-next
RUN if [ ${SIPE_ENABLED} -eq 1 ]; then cd /tmp \
 && apk add --no-cache --update --virtual .build-dependencies \
	build-base \
	git \
	flex \
	libtool \
	glib-dev \
	intltool \
	automake \
	autoconf \
	openssl-dev \
	libxml2-dev \
	pidgin-dev \
 && git clone -n https://github.com/tieto/sipe.git \
 && cd sipe \
 && git checkout ${SIPE_TAG} \
 && ./autogen.sh \
 && ./configure --build=x86_64-alpine-linux-musl --host=x86_64-alpine-linux-musl --prefix=/usr \
 && make \
 && make install \
 && strip /usr/lib/purple-2/libsipe.so \
 && rm -rf /tmp/* \
 && apk del .build-dependencies; fi

##############
# RocketChat #
##############
ARG ROCKETCHAT_ENABLED=1
ARG ROCKETCHAT_TAG=master
RUN if [ ${ROCKETCHAT_ENABLED} -eq 1 ]; then cd /tmp && \
    apk add --no-cache --update --virtual rocketchat-run-deps \
	    discount \
	    json-glib && \
	apk add --no-cache --update --virtual rocketchat-build-deps \
	    build-base \
	    git \
	    pidgin-dev \
	    json-glib-dev \
	    discount-dev && \
	git clone https://github.com/EionRobb/purple-rocketchat.git && \
	cd purple-rocketchat && \
	git checkout ${ROCKETCHAT_TAG} && \
	make && \
	make install && \
	strip /usr/lib/purple-2/librocketchat.so && \
	rm -rf /tmp/* && \
	apk del rocketchat-build-deps; fi

############
# Mastodon #
############
ARG MASTODON_ENABLED=1
ARG MASTODON_TAG=master
RUN if [ ${MASTODON_ENABLED} -eq 1 ]; then cd /tmp  && \
    apk add --no-cache --update --virtual mastodon-build-deps \
	    build-base \
	    git \
	    autoconf \
	    automake \
	    libtool \
	    glib-dev  && \
	git clone -n https://github.com/kensanata/bitlbee-mastodon.git  && \
	cd bitlbee-mastodon  && \
	git checkout ${MASTODON_TAG} && \
	chmod +x autogen.sh && \
	./autogen.sh  && \
	./configure \
	    --build=x86_64-alpine-linux-musl \
	    --host=x86_64-alpine-linux-musl  && \
	make  && \
	make install  && \
	strip /usr/lib/bitlbee/mastodon.so  && \
	rm -rf /tmp/*  && \
	apk del mastodon-build-deps; fi

##########
# Matrix #
##########
ARG MATRIX_ENABLED=1
ARG OLM_TAG=3.1.4
ARG MATRIX_TAG=master

RUN if [ ${MATRIX_ENABLED} -eq 1 ]; then cd /tmp && \
    apk add --no-cache --update --virtual matrix-run-deps \
	    sqlite \
	    http-parser \
	    libgcrypt \
	    json-glib && \
	apk add --no-cache --update --virtual matrix-build-deps \
	    build-base \
	    git \
	    libgcrypt-dev \
	    pidgin-dev \
	    json-glib-dev \
	    glib-dev \
	    sqlite-dev \
	    http-parser-dev && \
	git clone -n https://gitlab.matrix.org/matrix-org/olm.git && \
	cd olm && \
	git checkout ${OLM_TAG} && \
	make && \
	make install && \
	strip /usr/local/lib/libolm.so.${OLM_TAG} && \
	cd /tmp && \
	git clone -n https://github.com/matrix-org/purple-matrix.git && \
	cd purple-matrix && \
	git checkout ${MATRIX_TAG} && \
	make && \
	make install && \
	strip /usr/lib/purple-2/libmatrix.so && \
	rm -rf /tmp/* && \
	apk del matrix-build-deps; fi

##########
# Signal #
##########
ARG SIGNAL_ENABLED=1
ARG SIGNAL_TAG=master
RUN if [ ${SIGNAL_ENABLED} -eq 1 ]; then cd /tmp && \
	apk add --no-cache --update --virtual signal-build-deps \
	    build-base \
	    git \
	    libtool \
	    pidgin-dev \
	    glib-dev \
	    json-glib-dev && \
	git clone -n https://github.com/hoehermann/libpurple-signald.git && \
	cd libpurple-signald && \
	git checkout ${SIGNAL_TAG} && \
	make && \
	make install && \
	strip /usr/lib/purple-2/libsignald.so && \
	rm -rf /tmp/* && \
	apk del signal-build-deps; fi

USER bitlbee
EXPOSE 6667
CMD [ "/usr/sbin/bitlbee", "-F", "-n" ]
