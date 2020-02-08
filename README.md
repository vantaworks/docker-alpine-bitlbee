BitlBee with Plugins on Docker
==============================
[![Build Status](https://travis-ci.com/vantaworks/docker-alpine-bitlbee.svg?branch=master)](https://travis-ci.com/vantaworks/docker-alpine-bitlbee)


Information
-----------

### First, what is a BitlBee?
[BitlBee](1) is an IRC to IM gateway. As they state on their homepage...

> It's a great solution for people who have an IRC client running all the time and don't want to run an additional MSN/AIM/whatever client.

[1]: https://www.bitlbee.org/

### What exactly is this repo doing?
Ultimately, it is just a `Makefile` and `Dockerfile` that checks out known working versions of the plugins from the upstream repos and builds them.

### What will this work with?
Anything that runs Docker or a compatible container framework, can run this. One IM container to rule them all.

### Which protocols does it support?
Below are the projects bundled in the Docker Image:

1. Bitlbee natively supported protocols: https://wiki.bitlbee.org/
2. Discord: https://github.com/sm00th/bitlbee-discord
3. Facebook: https://github.com/bitlbee/bitlbee-facebook
4. Skypeweb: https://github.com/EionRobb/skype4pidgin
5. Slack: https://github.com/dylex/slack-libpurple
6. Mattermost: https://github.com/EionRobb/purple-mattermost
7. Google Hangouts: https://bitbucket.org/EionRobb/purple-hangouts
8. Steam: https://github.com/bitlbee/bitlbee-steam
9. Telegram: https://github.com/majn/telegram-purple
10. SIPE: https://github.com/tieto/sipe.git
11. RocketChat: https://bitbucket.org/EionRobb/purple-rocketchat
12. Mastodon: https://github.com/kensanata/bitlbee-mastodon
13. Matrix: https://github.com/matrix-org/purple-matrix
14. Signal: https://github.com/hoehermann/libpurple-signald

### Will you include x chat?
I'm fairly open to requests. File an issue, or shoot me over a PR and I'll see that we get it included.

Building
--------
Included is a `Makefile` that should handle most of the heavy lifting for a standard build. However you can customize the build args like so...
```
# This performs the whole build with all plugins
make all

# This example removes a most plugins, and pins them to specific commits from their respective projects.
docker build -t docker-alpine-bitlbee . \
  --build-arg SLACK_ENABLED=1 \
  --build-arg SLACK_TAG=8acc4eb \
  --build-arg HANGOUTS_ENABLED=1 \
  --build-arg HANGOUTS_TAG=3f7d89b \
  --build-arg DISCORD_ENABLED=0 \
  --build-arg FACEBOOK_ENABLED=0 \
  --build-arg SKYPEWEB_ENABLED=0 \
  --build-arg STEAM_ENABLED=0 \
  --build-arg TELEGRAM_ENABLED=0 \
  --build-arg SIPE_ENABLED=0 \
  --build-arg ROCKETCHAT_ENABLED=0 \
  --build-arg MATRIX_ENABLED=0 \
  --build-arg MATTERMOST_ENABLED=0 \
  --build-arg MASTODON_ENABLED=0 \
  --build-arg SIGNAL_ENABLED=0
```

Running
-------
For those running the upstream provided container:
```
docker run -d \
  --name bitlbee \
  --restart=always \
  -v /opt/bitlbee-data:/var/lib/bitlbee:rw \
  -v /etc/localtime:/etc/localtime:ro \
  -p 0.0.0.0:6667:6667 \
  thisisvantaworks/alpine-bitlbee:latest
```

For those who built their own locally:
```
docker run -d \
  --name bitlbee \
  --restart=always \
  -v /opt/bitlbee-data:/var/lib/bitlbee:rw \
  -v /etc/localtime:/etc/localtime:ro \
  -p 0.0.0.0:6667:6667 \
  docker-alpine-bitlbee:latest
```

