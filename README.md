BitlBee with Plugins
====================

Information
-----------

### First, what is a BitlBee?
[BitlBee](1) is an IRC to IM gateway. As they state on their homepage...

> It's a great solution for people who have an IRC client running all the time and don't want to run an additional MSN/AIM/whatever client.

[1]: https://www.bitlbee.org/

### What do plugins have to do with it?
Plugins allow BitlBee to connect to additional IM protocols. For an official list, see the [BitlBee Wiki](2)

[2]: https://wiki.bitlbee.org/

### What exactly is this repo doing?
Ultimately, it is just a `Makefile` that checks out known working versions of the plugins from the upstream repos and builds them.

### What will this work with?
This project was ultimately built to support Alpine Linux as a [Docker container](3); however, any system that has the following dependancies should work.

[3]: https://cloud.docker.com/repository/docker/h4110w33n/bitlbee-plugins-docker

###### Buildtime Requirements
autoconf
automake
build-base or build-essential
curl
git
json-glib-dev
libtool
protobuf-c-dev
mercurial

###### Runtime Requirements
glib-dev
gnutls-dev
json-glib
libotr-dev
libgcrypt-dev
libpurple
libwebp-dev
pidgin-dev

Install
-------
Just checkout this repo, and execute the `Makefile`. It should handle the rest.
```
git clone https://github.com/h4110w33n/bitlbee-plugins.git
cd bitlbee-plugins
make
make install
```

Install Notes
-------------
The default location for all the source repos is `/src`, and BitlBee configuration file is `/opt/bitlbee-data`. Both can be overridden `SRC_DIR` and `CONFIG_DIR` as shown below.
```
make CONFIG_DIR=/other/config/directory SRC_DIR=/other/source/directory
```
