BUILD_DIR ?= "/src"

include versions.mk

all: bitlbee-build discord-build facebook-build skype-build slack-build steam-build telegram-build hangouts-build

install: bitlbee-install discord-install facebook-install skype-install slack-install steam-install telegram-install hangouts-install

clean: bitlbee-clean discord-clean facebook-clean skype-clean slack-clean steam-clean telegram-clean hangouts-clean

clean-all: clean clean-self

bitlbee-build:
	@cd $(BUILD_DIR)
	git clone -n https://github.com/bitlbee/bitlbee -b $(BITLBEE_COMMIT)
	@cd bitlbee
	./configure --debug=0 --otr=1 --purple=1 --config=/opt/bitlbee-data
	make

bitlbee-install:
	@cd $(BUILD_DIR)/bitlbee
	make install
	make install-dev
	make install-etc

bitlbee-clean:
	rm -rf $(BUILD_DIR)/bitlbee

discord-build: bitlbee
	@cd $(BUILD_DIR)
	git clone -n https://github.com/sm00th/bitlbee-discord -b $(DISCORD_COMMIT)
	@cd bitlbee-discord
	./autogen.sh
	./configure
	make

discord-install:
	@cd $(BUILD_DIR)/bitlbee-discord
	make install

discord-clean:
	rm -rf $(BUILD_DIR)/bitlbee-discord

facebook-build: bitlbee
	@cd $(BUILD_DIR)
	git clone -n https://github.com/jgeboski/bitlbee-facebook -b $(FACEBOOK_COMMIT)
	@cd bitlbee-facebook
	./autogen.sh
	make

facebook-install:
	@cd $(BUILD_DIR)/bitlbee-facebook
	make install

facebook-clean:
	rm -rf $(BUILD_DIR)/bitlbee-facebook

skype-build: bitlbee
	@cd $(BUILD_DIR)
	git clone -n https://github.com/EionRobb/skype4pidgin -b $(SKYPE_COMMIT)
	@cd skype4pidgin/skypeweb
	make

skype-install:
	@cd $(BUILD_DIR)/skype4pidgin/skypeweb
	make install

skype-clean:
	rm -rf $(BUILD_DIR)/skype4pidgin

slack-build: bitlbee
	@cd $(BUILD_DIR)
	git clone -n https://github.com/dylex/slack-libpurple -b $(SLACK_COMMIT)
	@cd slack-libpurple
	make

slack-install:
	@cd $(BUILD_DIR)/slack-libpurple
	make install

steam-build: bitlbee
	@cd $(BUILD_DIR)
	git clone -n https://github.com/bitlbee/bitlbee-steam -b $(STEAM_COMMIT)
	@cd bitlbee-steam
	./autogen.sh
	make

steam-install:
	@cd $(BUILD_DIR)/bitlbee-steam
	make install

steam-clean:
	rm -rf $(BUILD_DIR)/bitlbee-steam

telegram-build: bitlbee
	@cd $(BUILD_DIR)
	git clone -n https://github.com/majn/telegram-purple -b $(TELEGRAM_COMMIT)
	@cd telegram-purple
	git submodule update --init --recursive
	./configure
	make

telegram-install:
	@cd $(BUILD_DIR)/telegram-purple
	make install

telegram-clean:
	rm -rf $(BUILD_DIR)/telegram-purple

hangouts-build: bitlbee
	@cd $(BUILD_DIR)
	hg clone https://bitbucket.org/EionRobb/purple-hangouts -r $(HANGOUTS_COMMIT)
	@cd purple-hangouts
	make
	make install

hangouts-install:
	@cd $(BUILD_DIR)/purple-hangouts
	make install

hangouts-clean:
	rm -rf $(BUILD_DIR)/purple-hangouts

clean-self:
	rm -rf $(BUILD_DIR)/bitlbee-plugins
