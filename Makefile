SRC_DIR ?= /src
CONFIG_DIR ?= /opt/bitlbee-data
CONTAINER_NAME ?= $(shell basename -s .git `git config --get remote.origin.url`)

.ONESHELL:
all: bitlbee-build bitlbee-install discord-build discord-install facebook-build facebook-install skype-build skype-install slack-build slack-install steam-build steam-install telegram-build telegram-install hangouts-build hangouts-install mattermost-build mattermost-install clean-all

build: bitlbee-build discord-build facebook-build skype-build slack-build steam-build telegram-build hangouts-build mattermost-build

install: bitlbee-install discord-install facebook-install skype-install slack-install steam-install telegram-install hangouts-install mattermost-install

clean: bitlbee-clean discord-clean facebook-clean skype-clean slack-clean steam-clean telegram-clean hangouts-clean mattermost-clean

clean-all: clean clean-self

bitlbee-build:
	@echo "*****************"
	@echo "* BITLBEE-BUILD *"
	@echo "*****************"
	cd $(SRC_DIR)
	@echo "* CLONING BITLBEE *"
	git clone https://github.com/bitlbee/bitlbee $(SRC_DIR)/bitlbee
	cd $(SRC_DIR)/bitlbee
	mkdir -p $(CONFIG_DIR)
	@echo "* AUTOCONFIG BITLBEE *"
	./configure --debug=0 --otr=1 --purple=1 --config=$(CONFIG_DIR)
	@echo "* MAKE BITLBEE *"
	make 

bitlbee-install:
	@echo "*******************"
	@echo "* BITLBEE-INSTALL *"
	@echo "*******************"
	@cd $(SRC_DIR)/bitlbee
	@echo "* INSTALL BITLBEE-MAIN *"
	make install
	@echo "* INSTALL BITLBEE-DEV *"
	make install-dev
	@echo "* INSTALL BITLBEE-ETC *"
	make install-etc

bitlbee-clean:
	@echo "*****************"
	@echo "* BITLBEE-CLEAN *"
	@echo "*****************"
	rm -rf $(SRC_DIR)/bitlbee

discord-build:
	@echo "*****************"
	@echo "* DISCORD-BUILD *"
	@echo "*****************"
	@cd $(SRC_DIR)
	@echo "* CLONING DISCORD *"
	git clone https://github.com/sm00th/bitlbee-discord $(SRC_DIR)/bitlbee-discord
	@cd $(SRC_DIR)/bitlbee-discord
	@echo "* AUTOCONFIG DISCORD *"
	./autogen.sh
	@echo "* CONFIG DISCORD *"
	./configure
	@echo "* MAKE DISCORD *"
	make

discord-install:
	@echo "*******************"
	@echo "* DISCORD-INSTALL *"
	@echo "*******************"
	@cd $(SRC_DIR)/bitlbee-discord
	make install

discord-clean:
	@echo "*****************"
	@echo "* DISCORD-CLEAN *"
	@echo "*****************"
	rm -rf $(SRC_DIR)/bitlbee-discord

facebook-build:
	@echo "******************"
	@echo "* FACEBOOK-BUILD *"
	@echo "******************"
	@cd $(SRC_DIR)
	@echo "* CLONING FACEBOOK *"
	git clone https://github.com/jgeboski/bitlbee-facebook $(SRC_DIR)/bitlbee-facebook
	@cd $(SRC_DIR)/bitlbee-facebook
	@echo "* AUTOCONFIG FACEBOOK *"
	./autogen.sh
	@echo "* MAKE FACEBOOK *"
	make

facebook-install:
	@echo "********************"
	@echo "* FACEBOOK-INSTALL *"
	@echo "********************"
	@cd $(SRC_DIR)/bitlbee-facebook
	make install

facebook-clean:
	@echo "******************"
	@echo "* FACEBOOK-CLEAN *"
	@echo "******************"
	rm -rf $(SRC_DIR)/bitlbee-facebook

skype-build:
	@echo "***************"
	@echo "* SKYPE-BUILD *"
	@echo "***************"
	@cd $(SRC_DIR)
	@echo "* CLONING SKYPE *"
	git clone https://github.com/EionRobb/skype4pidgin $(SRC_DIR)/skype4pidgin
	@cd $(SRC_DIR)/skype4pidgin/skypeweb
	@echo "* MAKE SKYPE *"
	make

skype-install:
	@echo "*****************"
	@echo "* SKYPE-INSTALL *"
	@echo "*****************"
	@cd $(SRC_DIR)/skype4pidgin/skypeweb
	make install

skype-clean:
	@echo "***************"
	@echo "* SKYPE-CLEAN *"
	@echo "***************"
	rm -rf $(SRC_DIR)/skype4pidgin

slack-build:
	@echo "***************"
	@echo "* SLACK-BUILD *"
	@echo "***************"	
	@cd $(SRC_DIR)
	@echo "* CLONING SKYPE *"
	git clone https://github.com/dylex/slack-libpurple $(SRC_DIR)/slack-libpurple
	@cd $(SRC_DIR)/slack-libpurple
	@echo "* MAKE SKYPE *"
	make

slack-install:
	@echo "*****************"
	@echo "* SLACK-INSTALL *"
	@echo "*****************"	
	@cd $(SRC_DIR)/slack-libpurple
	make install

slack-clean:
	@echo "***************"
	@echo "* SLACK-CLEAN *"
	@echo "***************"	
	rm -rf $(SRC_DIR)/slack-libpurple

steam-build:
	@echo "***************"
	@echo "* STEAM-BUILD *"
	@echo "***************"	
	@cd $(SRC_DIR)
	@echo "* CLONING SKYPE *"
	git clone https://github.com/bitlbee/bitlbee-steam $(SRC_DIR)/bitlbee-steam
	@cd $(SRC_DIR)/bitlbee-steam
	@echo "* AUTOCONFIG STEAM *"
	./autogen.sh
	@echo "* MAKE STEAM *"
	make

steam-install:
	@echo "*****************"
	@echo "* STEAM-INSTALL *"
	@echo "*****************"
	@cd $(SRC_DIR)/bitlbee-steam
	make install

steam-clean:
	@echo "***************"
	@echo "* STEAM-CLEAN *"
	@echo "***************"	
	rm -rf $(SRC_DIR)/bitlbee-steam

telegram-build:
	@echo "******************"
	@echo "* TELEGRAM-BUILD *"
	@echo "******************"
	@cd $(SRC_DIR)
	@echo "* CLONING TELEGRAM *"
	git clone https://github.com/majn/telegram-purple $(SRC_DIR)/telegram-purple
	@cd $(SRC_DIR)/telegram-purple
	@echo "* CLONING TELEGRAM-SUBMODULES *"
	git submodule update --init --recursive
	@echo "* AUTOCONFIG TELEGRAM *"
	./configure
	@echo "* MAKE TELEGRAM *"
	make

telegram-install:
	@echo "********************"
	@echo "* TELEGRAM-INSTALL *"
	@echo "********************"
	@cd $(SRC_DIR)/telegram-purple
	make install

telegram-clean:
	@echo "******************"
	@echo "* TELEGRAM-CLEAN *"
	@echo "******************"
	rm -rf $(SRC_DIR)/telegram-purple

hangouts-build:
	@echo "******************"
	@echo "* HANGOUTS-BUILD *"
	@echo "******************"
	@cd $(SRC_DIR)
	@echo "* CLONING HANGOUTS *"
	hg clone https://bitbucket.org/EionRobb/purple-hangouts $(SRC_DIR)/purple-hangouts
	@cd $(SRC_DIR)/purple-hangouts
	@echo "* MAKE HANGOUTS *"
	make

hangouts-install:
	@echo "********************"
	@echo "* HANGOUTS-INSTALL *"
	@echo "********************"
	@cd $(SRC_DIR)/purple-hangouts
	make install

hangouts-clean:
	@echo "******************"
	@echo "* HANGOUTS-CLEAN *"
	@echo "******************"
	rm -rf $(SRC_DIR)/purple-hangouts

mattermost-build:
	@echo "********************"
	@echo "* MATTERMOST-BUILD *"
	@echo "********************"
	cd $(SRC_DIR)
	@echo "* CLONING MATTERMOST *"
	git clone https://github.com/EionRobb/purple-mattermost.git $(SRC_DIR)/purple-mattermost
	cd $(SRC_DIR)/purple-mattermost
	@echo "* MAKE MATTERMOST *"
	make

mattermost-install:
	@echo "**********************"
	@echo "* MATTERMOST-INSTALL *"
	@echo "**********************"
	@cd $(SRC_DIR)/purple-mattermost
	make install

mattermost-clean:
	@echo "********************"
	@echo "* MATTERMOST-CLEAN *"
	@echo "********************"
	rm -rf $(SRC_DIR)/purple-mattermost

clean-self:
	@echo "***************"
	@echo "* CLEAN-SELF *"
	@echo "**************"
	rm -rf $(SRC_DIR)/bitlbee-plugins

# Docker Related image building (testing utilities)

docker-clean:
	@docker stop ${CONTAINER_NAME} || echo no container to remove && true
	@docker rm ${CONTAINER_NAME} || echo no container to remove && true
	@docker image rm ${CONTAINER_NAME} || echo no image to remove && true

docker: docker-clean
	docker build -t ${CONTAINER_NAME} .
