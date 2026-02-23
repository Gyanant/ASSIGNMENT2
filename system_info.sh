#!/bin/bash

#Color Codes
BLUE="\e[34m"
GREEN="\e[32m"
CYAN="\e[36m"
RESET="\e[0m"

#Storing info as variables
USERNAME=$(whoami)
HOSTNAME=$(hostname)
DATETIME=$(date)
OS=$(uname -s)
CURRENT_DIR=$(pwd)
HOME_DIR=$HOME
USERS_ONLINE=$(who | wc -l)
UPTIME=$(uptime -p)

# Bonus Info
DISK_USAGE=$(df -h)
MEMORY_USAGE=$(free -h)


# Display Output
echo -e "${BLUE}╔════════════════════════════════════════╗"
echo -e "${BLUE}║${RESET}        SYSTEM INFORMATION DISPLAY${RESET}      ${BLUE}║${RESET}"

echo -e "${BLUE}║${RESET}${GREEN}Username      :${RESET} $USERNAME                    ${BLUE}║${RESET}"
echo -e "${BLUE}║${RESET}${GREEN}Hostname      :${RESET} $HOSTNAME                    ${BLUE}║${RESET}"
echo -e "${BLUE}║${RESET}${GREEN}Date & Time   :${RESET} $DATETIME${BLUE}║${RESET}"
echo -e "${BLUE}║${RESET}${GREEN}OS            :${RESET} $OS                   ${BLUE}║${RESET}"
echo -e "${BLUE}║${RESET}${GREEN}Current Dir   :${RESET} $CURRENT_DIR  ${BLUE}║${RESET}"
echo -e "${BLUE}║${RESET}${GREEN}Home Dir      :${RESET} $HOME_DIR              ${BLUE}║${RESET}"
echo -e "${BLUE}║${RESET}${GREEN}Users Online  :${RESET} $USERS_ONLINE                       ${BLUE}║${RESET}"
echo -e "${BLUE}║${RESET}${GREEN}Uptime        :${RESET} $UPTIME           ${BLUE}║${RESET}"
echo -e "${BLUE}╚════════════════════════════════════════╝${RESET}"