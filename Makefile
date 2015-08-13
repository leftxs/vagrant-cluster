SHELL := /bin/bash
VENV=.

# Colors
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
#echo "${red}red text ${green}green text${reset}"

.PHONY: bootstrap check plugin-update

bootstrap:
	@echo "${green}>>> Creating virtualenv${reset}"
	virtualenv --python=python2.7 --no-site-packages $(VENV)

	@echo -e "${green}>>> Install Ansible...${reset}"
	bash -c "source bin/activate && pip install ansible"

	@echo -e "${green}>>> Install Pip-tools...${reset}"
	bash -c "source bin/activate && pip install pip-tools"

check:
	@echo -e "${green}>>> Checking dependencies ...${reset}"
	./check.sh

plugin-update:
	@echo -e "${green}>>> Update vagrant-plugins ...${reset}"
	vagrant plugin update

pip-update:
	@echo -e"${green}>>> Upgrading all packes installed with pip${reset}"
	bash -c "source bin/activate && pip-review --auto"

pip-list:
	@echo -e"${green}>>> Creating requirements.txt with all your packages installed by pip${reset}"
	bash -c "source bin/activate && pip-dump"

boot:
	@echo -e "${green}>>> Hold on we are booting now!...${reset}"
	bash -c "source bin/activate && vagrant up"

provision:
	@echo -e "${green}>>> Run ansible against box${reset}"
	bash -c "source bin/activate && vagrant provision"


install: check bootstrap

all: check bootstrap boot
