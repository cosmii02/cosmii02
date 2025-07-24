#!/bin/bash

# Variables
PSK_FILE="/etc/zabbix/zabbix_agentd.psk"
ZABBIX_AGENT_CONF="/etc/zabbix/zabbix_agentd.conf"
VERBOSE=0

# Function to determine the OS
get_os() {
    . /etc/os-release
    echo "$ID$VERSION_ID"
}

# Function to determine if OS is RHEL-based
is_rhel_based() {
    OS=$(get_os)
    if [[ "$OS" == *"rocky"* ]] || [[ "$OS" == *"almalinux"* ]] || [[ "$OS" == *"centos"* ]] || [[ "$OS" == *"rhel"* ]]; then
        return 0
    else
        return 1
    fi
}

# Check for verbose flag
while getopts "v" opt; do
  case $opt in
    v)
      VERBOSE=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

# Colors for nice output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to execute commands
execute() {
    if [ $VERBOSE -eq 1 ]; then
        "$@"
    else
        "$@" > /dev/null 2>&1
    fi
}

# Function to print messages conditionally based on verbosity
print_message() {
    if [ $VERBOSE -eq 1 ]; then
        echo -e "$1"
    fi
}

# Simple animation function
animate() {
    if [ $VERBOSE -eq 0 ]; then
        echo -n "Uninstalling"
        while true; do
            echo -n "."
            sleep 1
        done
    fi
}

# Start animation
animate & ANIMATE_PID=$!
disown

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   print_message "${RED}This script must be run as root${NC}" "error"
   kill $ANIMATE_PID
   exit 1
fi

# Step 1: Stop Zabbix agent service
print_message "${GREEN}Stopping Zabbix agent service...${NC}"
execute systemctl stop zabbix-agent

# Step 2: Disable Zabbix agent service
print_message "${GREEN}Disabling Zabbix agent service...${NC}"
execute systemctl disable zabbix-agent

# Step 3: Remove Zabbix agent package
print_message "${GREEN}Removing Zabbix agent package...${NC}"
if is_rhel_based; then
    execute dnf remove -y zabbix-agent
    execute dnf remove -y zabbix-release
else
    execute apt remove --purge -y zabbix-agent
fi

# Step 4: Remove PSK file
if [ -f "$PSK_FILE" ]; then
    print_message "${GREEN}Removing PSK file...${NC}"
    execute rm -f $PSK_FILE
fi

# Step 5: Remove Zabbix agent configuration file
if [ -f "$ZABBIX_AGENT_CONF" ]; then
    print_message "${GREEN}Removing Zabbix agent configuration file...${NC}"
    execute rm -f $ZABBIX_AGENT_CONF
fi

# Step 6: Clean up downloaded packages
print_message "${GREEN}Cleaning up downloaded packages...${NC}"
if is_rhel_based; then
    execute dnf autoremove -y
    execute dnf clean all
else
    execute apt autoremove -y
    execute apt autoclean -y
fi

# Kill the animation process and add a newline for formatting
kill $ANIMATE_PID
echo ""

# Always print the successful uninstall message
echo -e "${GREEN}Zabbix agent and related files have been removed successfully.${NC}"
