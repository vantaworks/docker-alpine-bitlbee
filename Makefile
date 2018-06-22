SRC_DIR ?= /src
CONFIG_DIR ?= /opt/bitlbee-data

include versions.mk

all: bitlbee-build discord-build facebook-build skype-build slack-build steam-build telegram-build hangouts-build

install: bitlbee-install discord-install facebook-install skype-install slack-install steam-install telegram-install hangouts-install

clean: bitlbee-clean discord-clean facebook-clean skype-clean slack-clean steam-clean telegram-clean hangouts-clean

clean-all: clean clean-self

bitlbee-build:
	@cd $(SRC_DIR)
	git clone -n https://github.com/bitlbee/bitlbee -b $(BITLBEE_COMMIT)
	@cd bitlbee
	./configure --debug=0 --otr=1 --purple=1 --config=$(CONFIG_DIR)
	make

bitlbee-install:
	@cd $(SRC_DIR)/bitlbee
	make install
	make install-dev
	make install-etc

bitlbee-clean:
	rm -rf $(SRC_DIR)/bitlbee

discord-build: bitlbee
	@cd $(SRC_DIR)
	git clone -n https://github.com/sm00th/bitlbee-discord -b $(DISCORD_COMMIT)
	@cd bitlbee-discord
	./autogen.sh
	./configure
	make

discord-install:
	@cd $(SRC_DIR)/bitlbee-discord
	make install

discord-clean:
	rm -rf $(SRC_DIR)/bitlbee-discord

facebook-build: bitlbee
	@cd $(SRC_DIR)
	git clone -n https://github.com/jgeboski/bitlbee-facebook -b $(FACEBOOK_COMMIT)
	@cd bitlbee-facebook
	./autogen.sh
	make

facebook-install:
	@cd $(SRC_DIR)/bitlbee-facebook
	make install

facebook-clean:
	rm -rf $(SRC_DIR)/bitlbee-facebook

skype-build: bitlbee
	@cd $(SRC_DIR)
	git clone -n https://github.com/EionRobb/skype4pidgin -b $(SKYPE_COMMIT)
	@cd skype4pidgin/skypeweb
	make

skype-install:
	@cd $(SRC_DIR)/skype4pidgin/skypeweb
	make install

skype-clean:
	rm -rf $(SRC_DIR)/skype4pidgin

slack-build: bitlbee
	@cd $(SRC_DIR)
	git clone -n https://github.com/dylex/slack-libpurple -b $(SLACK_COMMIT)
	@cd slack-libpurple
	make

slack-install:
	@cd $(SRC_DIR)/slack-libpurple
	make install

steam-build: bitlbee
	@cd $(SRC_DIR)
	git clone -n https://github.com/bitlbee/bitlbee-steam -b $(STEAM_COMMIT)
	@cd bitlbee-steam
	./autogen.sh
	make

steam-install:
	@cd $(SRC_DIR)/bitlbee-steam
	make install

steam-clean:
	rm -rf $(SRC_DIR)/bitlbee-steam

telegram-build: bitlbee
	@cd $(SRC_DIR)
	git clone -n https://github.com/majn/telegram-purple -b $(TELEGRAM_COMMIT)
	@cd telegram-purple
	git submodule update --init --recursive
	./configure
	make

telegram-install:
	@cd $(SRC_DIR)/telegram-purple
	make install

telegram-clean:
	rm -rf $(SRC_DIR)/telegram-purple

hangouts-build: bitlbee
	@cd $(SRC_DIR)
	hg clone https://bitbucket.org/EionRobb/purple-hangouts -r $(HANGOUTS_COMMIT)
	@cd purple-hangouts
	make
	make install

hangouts-install:
	@cd $(SRC_DIR)/purple-hangouts
	make install

hangouts-clean:
	rm -rf $(SRC_DIR)/purple-hangouts

clean-self:
	rm -rf $(SRC_DIR)/bitlbee-plugins
