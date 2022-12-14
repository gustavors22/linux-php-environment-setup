#!/bin/bash

function install_git {
	sudo apt install git
}

function install_php {
	#add Repositories
	sudo apt install software-properties-common
	sudo add-apt-repository ppa:ondrej/php
	sudo apt update

	#install PHP 7.4
	sudo apt install php7.4

	#install php 7.4 extensions
	sudo apt install php7.4-common php7.4-mysql php7.4-xml \
	 php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli \
	 php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl -y
}

function install_composer {
	#install necessary requirements
	sudo apt update
	sudo apt install wget unzip

	#download composer
	wget -O composer-setup.php https://getcomposer.org/installer

	#install composer
	sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
}

function install_curl {
	sudo apt install curl
}

function install_docker {
	#pre instalation
	sudo apt-get update
	sudo apt-get install \
    	ca-certificates \
    	curl \
    	gnupg \
    	lsb-release

	#add official GPG key
	sudo mkdir -p /etc/apt/keyrings
 	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

	#setup repository
	echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	#install docker engine
	sudo apt-get update
 	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

	#docker post installation
	sudo groupadd docker
	sudo usermod -aG docker $USER
}

function install_nvm {
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
}

function install_yarn {
	npm i yarn -g
}

function install_node_lts {
	install_nvm

	nvm install --lts
	nvm use --lts

	install_yarn
}

function install_vscode {
	#add repository
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

	#install vscode
	sudo apt install code
}

function install_dbeaver {
	#dowload dbeaver.deb
	wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb

	#Install dbeaver
	sudo dpkg -i dbeaver-ce_latest_amd64.deb
	sudo apt install -f
}

function main {
	install_curl
	install_git
	install_php
	install_composer
	install_node_lts
	install_docker
	install_vscode
	install_dbeaver
}

main