SRC_DIR ?= /src
CONFIG_DIR ?= /opt/bitlbee-data

include versions.mk

.ONESHELL:
all: bitlbee-build bitlbee-install discord-build discord-install facebook-build facebook-install skype-build skype-install slack-build slack-install steam-build steam-install telegram-build telegram-install hangouts-build hangouts-install clean

build: bitlbee-build discord-build facebook-build skype-build slack-build steam-build telegram-build hangouts-build

install: bitlbee-install discord-install facebook-install skype-install slack-install steam-install telegram-install hangouts-install

clean: bitlbee-clean discord-clean facebook-clean skype-clean slack-clean steam-clean telegram-clean hangouts-clean

clean-all: clean clean-self

bitlbee-build:
	cd $(SRC_DIR)
	git clone -n https://github.com/bitlbee/bitlbee $(SRC_DIR)/bitlbee
	cd $(SRC_DIR)/bitlbee
	git reset --hard $(BITLBEE_COMMIT)
	mkdir -p $(CONFIG_DIR)
	./configure --debug=0 --otr=1 --purple=1 --config=$(CONFIG_DIR)
	make

bitlbee-install:
	@cd $(SRC_DIR)/bitlbee
	make install
	make install-dev
	make install-etc

bitlbee-clean:
	rm -rf $(SRC_DIR)/bitlbee

discord-build:
	@cd $(SRC_DIR)
	git clone -n https://github.com/sm00th/bitlbee-discord $(SRC_DIR)/bitlbee-discord
	@cd $(SRC_DIR)/bitlbee-discord
	git reset --hard $(DISCORD_COMMIT)
	./autogen.sh
	./configure
	make

discord-install:
	@cd $(SRC_DIR)/bitlbee-discord
	make install

discord-clean:
	rm -rf $(SRC_DIR)/bitlbee-discord

facebook-build:
	@cd $(SRC_DIR)
	git clone -n https://github.com/jgeboski/bitlbee-facebook $(SRC_DIR)/bitlbee-facebook
	@cd $(SRC_DIR)/bitlbee-facebook
	git reset --hard $(FACEBOOK_COMMIT)
	./autogen.sh
	make

facebook-install:
	@cd $(SRC_DIR)/bitlbee-facebook
	make install

facebook-clean:
	rm -rf $(SRC_DIR)/bitlbee-facebook

skype-build:
	@cd $(SRC_DIR)
	git clone -n https://github.com/EionRobb/skype4pidgin $(SRC_DIR)/skype4pidgin
	@cd $(SRC_DIR)/skype4pidgin/skypeweb
	git reset --hard $(SKYPE_COMMIT)
	make

skype-install:
	@cd $(SRC_DIR)/skype4pidgin/skypeweb
	make install

skype-clean:
	rm -rf $(SRC_DIR)/skype4pidgin

slack-build:
	@cd $(SRC_DIR)
	git clone -n https://github.com/dylex/slack-libpurple $(SRC_DIR)/slack-libpurple
	@cd $(SRC_DIR)/slack-libpurple
	git reset --hard $(SLACK_COMMIT)
	make

slack-install:
	@cd $(SRC_DIR)/slack-libpurple
	make install

steam-build:
	@cd $(SRC_DIR)
	git clone -n https://github.com/bitlbee/bitlbee-steam $(SRC_DIR)/bitlbee-steam
	@cd $(SRC_DIR)/bitlbee-steam
	git reset --hard $(STEAM_COMMIT)
	./autogen.sh
	make

steam-install:
	@cd $(SRC_DIR)/bitlbee-steam
	make install

steam-clean:
	rm -rf $(SRC_DIR)/bitlbee-steam

telegram-build:
	@cd $(SRC_DIR)
	git clone -n https://github.com/majn/telegram-purple $(SRC_DIR)/telegram-purple
	@cd $(SRC_DIR)/telegram-purple
	git reset --hard $(TELEGRAM_COMMIT)
	git submodule update --init --recursive
	./configure
	make

telegram-install:
	@cd $(SRC_DIR)/telegram-purple
	make install

telegram-clean:
	rm -rf $(SRC_DIR)/telegram-purple

hangouts-build:
	@cd $(SRC_DIR)
	hg clone https://bitbucket.org/EionRobb/purple-hangouts -r $(HANGOUTS_COMMIT) $(SRC_DIR)/purple-hangouts
	@cd $(SRC_DIR)/purple-hangouts
	make
	make install

hangouts-install:
	@cd $(SRC_DIR)/purple-hangouts
	make install

hangouts-clean:
	rm -rf $(SRC_DIR)/purple-hangouts

clean-self:
	rm -rf $(SRC_DIR)/bitlbee-plugins
