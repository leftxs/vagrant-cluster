#!/bin/bash

PROGNAME=$(basename $0)

# Colors
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

function check_vagrant_plugins()
{
# Check if all needed vagrant plugins all installed
PLUGINS='vagrant-hostsupdater vagrant-cachier vagrant-vbguest'
for plugin in $PLUGINS; do
    if vagrant plugin list | grep -q "$plugin"
        then
            echo "${green} $plugin is installed ${reset}"
        else
            echo "${green} Installing $plugin ${reset}"
            vagrant plugin install $plugin
        fi
done
}

# error function
function error_exit ()
{

#   ----------------------------------------------------------------
#   Function for exit due to fatal program error
#       Accepts 1 argument:
#           string containing descriptive error message
#   ----------------------------------------------------------------


    echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
    exit 1
}

# Example call of the error_exit function.  Note the inclusion
# of the LINENO environment variable.  It contains the current
# line number.

# First check if we can detect a venv, if yes continue, if not stop with  error
function check_venv ()
{
if [[ -z $VIRTUAL_ENV ]]; then
    error_exit "$LINENO":"${red}Please make sure that virtualenv is installed and activated${reset}"
else .
fi
}

check_vagrant_plugins

