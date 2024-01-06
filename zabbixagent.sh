#!/bin/bash

# Variables
ZABBIX_REPO_AMD64="https://repo.zabbix.com/zabbix/6.5/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.5-1+ubuntu22.04_all.deb"
ZABBIX_REPO_ARM64="https://repo.zabbix.com/zabbix/6.5/ubuntu-arm64/pool/main/z/zabbix-release/zabbix-release_6.5-1+ubuntu22.04_all.deb"
PSK_FILE="/etc/zabbix/zabbix_agentd.psk"
VERBOSE=0

# Ask the user for the Zabbix server IP
echo -n "Please enter the Zabbix server IP: "
read -r ZABBIX_SERVER_IP

# Validate the input if needed (basic format check)
if ! [[ $ZABBIX_SERVER_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid IP format. Exiting."
    exit 1
fi

# Check for verbose flag
while getopts "v" opt; do
  case $opt in
    v)
      VERBOSE=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Determine system architecture
ARCH=$(dpkg --print-architecture)
if [ "$ARCH" == "amd64" ]; then
    ZABBIX_REPO=$ZABBIX_REPO_AMD64
else
    ZABBIX_REPO=$ZABBIX_REPO_ARM64
fi

# Colors for nice output and PSK identity/PSK
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to execute commands
execute() {
    if [[ "$*" == openssl* ]]; then
        # Always write the output of the openssl command to the PSK file.
        "$@" > $PSK_FILE
    elif [ $VERBOSE -eq 1 ]; then
        "$@"
    else
        "$@" > /dev/null 2>&1
    fi
}

# Function to print messages
print_message() {
    if [ $VERBOSE -eq 1 ]; then
        if [ "$2" == "error" ]; then
            echo -e "${RED}$1${NC}"
        else
            echo -e "${GREEN}$1${NC}"
        fi
    fi
}

# Generate a random 5-letter PSK identity
PSK_IDENTITY=$(cat /dev/urandom | tr -dc 'A-Za-z' | fold -w 5 | head -n 1)

# Simple animation function
animate() {
    if [ $VERBOSE -eq 0 ]; then
        echo -n "Installing"
        while true; do
            echo -n "."
            sleep 1
        done
    fi
}

# Start animation
animate & ANIMATE_PID=$!
disown

# Step a: Install Zabbix release
print_message "Downloading and installing Zabbix release for $ARCH..."
execute wget $ZABBIX_REPO \
    && execute dpkg -i $(basename $ZABBIX_REPO) \
    && execute apt update || { print_message "Failed to install Zabbix release! Exiting." "error"; kill $ANIMATE_PID; exit 1; }

# Step b: Install Zabbix agent
print_message "Installing Zabbix agent..."
execute apt install -y zabbix-agent || { print_message "Failed to install Zabbix agent! Exiting." "error"; kill $ANIMATE_PID; exit 1; }

# Configuring Zabbix agent
print_message "Configuring Zabbix agent..."
execute sed -i "s/^Server=127.0.0.1/Server=$ZABBIX_SERVER_IP/" /etc/zabbix/zabbix_agentd.conf
execute sed -i "s/^ServerActive=127.0.0.1/ServerActive=$ZABBIX_SERVER_IP/" /etc/zabbix/zabbix_agentd.conf

# Generating PSK and setting permissions
print_message "Generating and configuring PSK..."
execute openssl rand -hex 32
execute chmod 744 $PSK_FILE
execute echo "TLSConnect=psk" >> /etc/zabbix/zabbix_agentd.conf
execute echo "TLSAccept=psk" >> /etc/zabbix/zabbix_agentd.conf
execute echo "TLSPSKIdentity=$PSK_IDENTITY" >> /etc/zabbix/zabbix_agentd.conf
execute echo "TLSPSKFile=$PSK_FILE" >> /etc/zabbix/zabbix_agentd.conf

# Step c: Start Zabbix agent process and enable at system boot
print_message "Starting and enabling Zabbix agent..."
execute systemctl restart zabbix-agent
execute systemctl enable zabbix-agent || { print_message "Failed to start/enable Zabbix agent! Exiting." "error"; kill $ANIMATE_PID; exit 1; }

# Kill the animation process and add a newline for formatting
kill $ANIMATE_PID
echo ""

# Check and print the PSK
if [ -f "$PSK_FILE" ] && [ -r "$PSK_FILE" ]; then
    PSK_CONTENT=$(cat $PSK_FILE)
else
    PSK_CONTENT="PSK file not found or not readable."
fi

# Print out the PSK Identity and PSK with color, always
echo -e "${BLUE}Your PSK Identity is: ${YELLOW}$PSK_IDENTITY${NC}"
echo -e "${BLUE}Your PSK is: ${YELLOW}$PSK_CONTENT${NC}"
