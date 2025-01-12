#!/bin/bash

# ----------------------------
# Color and Icon Definitions
# ----------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
RESET='\033[0m'

CHECKMARK="✅"
ERROR="❌"
PROGRESS="⏳"
INSTALL="🛠️"
STOP="⏹️"
RESTART="🔄"
LOGS="📄"
EXIT="🚪"
INFO="ℹ️"

# ----------------------------
# Check if packages are already installed
# ----------------------------

check_package_installed() {
    dpkg -l | grep -i $1 &>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "${CHECKMARK} $1 is already installed.${RESET}"
    else
        echo -e "${ERROR} $1 is not installed. Installing...${RESET}"
        return 1
    fi
    return 0
}

# ----------------------------
# Install Docker and Docker Compose
# ----------------------------
install_docker() {
    echo -e "${INSTALL} Installing Docker and Docker Compose...${RESET}"
    sudo apt update && sudo apt upgrade -y
    if ! check_package_installed "docker.io"; then
        sudo apt install docker.io -y
        sudo systemctl start docker
        sudo systemctl enable docker
    fi
    if ! check_package_installed "docker-compose"; then
        sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
    fi
    echo -e "${CHECKMARK} Docker and Docker Compose installed successfully.${RESET}"
}

# ----------------------------
# Stop OpenLedger Containers
# ----------------------------
stop_openledger() {
    echo -e "${STOP} Stopping OpenLedger containers...${RESET}"
    docker stop opl_scraper opl_worker
    echo -e "${CHECKMARK} OpenLedger containers stopped.${RESET}"
}

# ----------------------------
# Install OpenLedger
# ----------------------------
install_openledger() {
    echo -e "${INSTALL} Installing OpenLedger...${RESET}"
    # Check if unzip is installed
    check_package_installed "unzip" || sudo apt install unzip -y
    check_package_installed "libasound2" || sudo apt-get install libasound2 -y

    # Download OpenLedger
    wget https://cdn.openledger.xyz/openledger-node-1.0.0-linux.zip

    # Install OpenLedger
    unzip openledger-node-1.0.0-linux.zip
    sudo dpkg -i openledger-node-1.0.0.deb
    sudo apt-get install desktop-file-utils

    echo -e "${CHECKMARK} OpenLedger installed successfully.${RESET}"
}

# ----------------------------
# Start OpenLedger Node
# ----------------------------
start_openledger() {
    echo -e "${PROGRESS} Starting OpenLedger Node...${RESET}"
    openledger-node --no-sandbox
    echo -e "${CHECKMARK} OpenLedger Node started.${RESET}"
}

# ----------------------------
# Display ASCII Art and Welcome Message
# ----------------------------
display_ascii() {
    clear
    echo -e "    ${RED}    ____  __ __    _   ______  ____  ___________${RESET}"
    echo -e "    ${GREEN}   / __ \\/ //_/   / | / / __ \\/ __ \\/ ____/ ___/${RESET}"
    echo -e "    ${BLUE}  / / / / ,<     /  |/ / / / / / / / __/  \\__ \\ ${RESET}"
    echo -e "    ${YELLOW} / /_/ / /| |   / /|  / /_/ / /_/ / /___ ___/ / ${RESET}"
    echo -e "    ${MAGENTA}/_____/_/ |_|  /_/ |_/\____/_____/_____//____/  ${RESET}"
    echo -e "    ${MAGENTA}🚀 Follow us on Telegram: https://t.me/dknodes${RESET}"
    echo -e "    ${MAGENTA}📢 Follow us on Twitter: https://x.com/dknodes${RESET}"
    echo -e ""
    echo -e "    ${GREEN}Welcome to the OpenLedger Node Installation Wizard!${RESET}"
    echo -e ""
}

# ----------------------------
# Main Menu
# ----------------------------
show_menu() {
    clear
    display_ascii
    echo -e "    ${YELLOW}Choose an option:${RESET}"
    echo -e "    ${CYAN}1.${RESET} ${INSTALL} Install OpenLedger"
    echo -e "    ${CYAN}2.${RESET} ${STOP} Stop OpenLedger Containers"
    echo -e "    ${CYAN}3.${RESET} ${INSTALL} Start OpenLedger Node"
    echo -e "    ${CYAN}4.${RESET} ${EXIT} Exit"
    echo -ne "    ${YELLOW}Enter your choice [1-4]: ${RESET}"
}

# ----------------------------
# Main Loop
# ----------------------------
while true; do
    show_menu
    read choice
    case $choice in
        1)
            install_openledger
            ;;
        2)
            stop_openledger
            ;;
        3)
            start_openledger
            ;;
        4)
            echo -e "${EXIT} Exiting...${RESET}"
            exit 0
            ;;
        *)
            echo -e "${ERROR} Invalid option. Please try again.${RESET}"
            read -p "Press enter to continue..."
            ;;
    esac
done
