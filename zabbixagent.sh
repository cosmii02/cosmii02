#!/bin/bash

# Variables
ZABBIX_REPO_AMD64="https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu24.04_all.deb"
ZABBIX_REPO_ARM64="https://repo.zabbix.com/zabbix/7.0/ubuntu-arm64/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu24.04_all.deb"
DEBIAN12_REPO="https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.0+debian12_all.deb"
ROCKY9_REPO="https://repo.zabbix.com/zabbix/7.0/rocky/9/x86_64/zabbix-release-latest-7.0.el9.noarch.rpm"
ALMA9_REPO="https://repo.zabbix.com/zabbix/7.0/alma/9/x86_64/zabbix-release-latest-7.0.el9.noarch.rpm"
PSK_FILE="/etc/zabbix/zabbix_agentd.psk"
VERBOSE=0

# Colors for nice output and error messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print messages
print_message() {
    if [ "$2" == "error" ]; then
        echo -e "${RED}$1${NC}"
    else
        echo -e "${GREEN}$1${NC}"
    fi
}

# Function to determine the OS
get_os() {
    . /etc/os-release
    echo "$ID$VERSION_ID"
}

# Check if wget is installed
if ! command -v wget &> /dev/null; then
    print_message "ERROR: wget not installed" "error"
    exit 1
fi

# Ask the user for the Zabbix server IP
echo -n "Please enter the Zabbix server IP: "
read -r ZABBIX_SERVER_IP

# Validate the input if needed (basic format check)
if ! [[ $ZABBIX_SERVER_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    print_message "Invalid IP format. Exiting." "error"
    exit 1
fi

# Check for verbose flag
while getopts "v" opt; do
  case $opt in
    v)
      VERBOSE=1
      ;;
    \?)
      print_message "Invalid option: -$OPTARG" "error"
      exit 1
      ;;
  esac
done

# Determine system architecture
if command -v dpkg &> /dev/null; then
    ARCH=$(dpkg --print-architecture)
else
    ARCH=$(uname -m)
    # Convert common arch names for consistency
    case "$ARCH" in
        x86_64)
            ARCH="amd64"
            ;;
        aarch64)
            ARCH="arm64"
            ;;
    esac
fi

# Determine the OS and set the Zabbix Repo accordingly
OS=$(get_os)
if [[ "$OS" == ubuntu24.04* ]]; then
    if [ "$ARCH" == "amd64" ]; then
        ZABBIX_REPO=$ZABBIX_REPO_AMD64
    else
        ZABBIX_REPO=$ZABBIX_REPO_ARM64
    fi
elif [[ "$OS" == debian12* ]]; then
    ZABBIX_REPO=$DEBIAN12_REPO
elif [[ "$OS" == rocky9* ]]; then
    ZABBIX_REPO=$ROCKY9_REPO
elif [[ "$OS" == almalinux9* ]]; then
    ZABBIX_REPO=$ALMA9_REPO
else
    print_message "Unsupported OS: $OS. Exiting." "error"
    exit 1
fi

# Function to execute commands
execute() {
    if [ $VERBOSE -eq 1 ]; then
        "$@"
    else
        "$@" > /dev/null 2>&1
    fi
}

# Ask user for PSK preference
echo ""
echo "PSK Configuration:"
echo "1) Generate random PSK identity and key (recommended)"
echo "2) Specify custom PSK identity and key"
echo -n "Choose option (1 or 2): "
read -r PSK_CHOICE

if [ "$PSK_CHOICE" == "2" ]; then
    echo -n "Enter PSK Identity: "
    read -r PSK_IDENTITY
    echo -n "Enter PSK Key (64-character hex string): "
    read -r PSK_KEY
    
    # Basic validation for PSK key format
    if ! [[ $PSK_KEY =~ ^[0-9a-fA-F]{64}$ ]]; then
        print_message "Invalid PSK key format. Must be 64-character hex string. Exiting." "error"
        exit 1
    fi
else
    # Generate a random 5-letter PSK identity
    PSK_IDENTITY=$(cat /dev/urandom | tr -dc 'A-Za-z' | fold -w 5 | head -n 1)
    PSK_KEY=""
fi

# Start animation
animate & ANIMATE_PID=$!
disown

# Step a: Install Zabbix release
print_message "Downloading and installing Zabbix release for $ARCH..."
if [[ "$OS" == rocky9* ]] || [[ "$OS" == almalinux9* ]]; then
    # For AlmaLinux, disable Zabbix packages from EPEL if installed
    if [[ "$OS" == almalinux9* ]] && [ -f /etc/yum.repos.d/epel.repo ]; then
        print_message "Disabling Zabbix packages from EPEL repository..."
        execute sed -i '/^\[epel\]/a excludepkgs=zabbix*' /etc/yum.repos.d/epel.repo
    fi
    
    execute rpm -Uvh $ZABBIX_REPO \
        && execute dnf clean all || { print_message "Failed to install Zabbix release! Exiting." "error"; kill $ANIMATE_PID; exit 1; }
else
    execute wget $ZABBIX_REPO \
        && execute dpkg -i $(basename $ZABBIX_REPO) \
        && execute apt update || { print_message "Failed to install Zabbix release! Exiting." "error"; kill $ANIMATE_PID; exit 1; }
fi

# Step b: Install Zabbix agent
print_message "Installing Zabbix agent..."
if [[ "$OS" == rocky9* ]] || [[ "$OS" == almalinux9* ]]; then
    execute dnf install -y zabbix-agent || { print_message "Failed to install Zabbix agent! Exiting." "error"; kill $ANIMATE_PID; exit 1; }
else
    execute apt install -y zabbix-agent || { print_message "Failed to install Zabbix agent! Exiting." "error"; kill $ANIMATE_PID; exit 1; }
fi

# Configuring Zabbix agent
print_message "Configuring Zabbix agent..."
execute sed -i "s/^Server=127.0.0.1/Server=$ZABBIX_SERVER_IP/" /etc/zabbix/zabbix_agentd.conf
execute sed -i "s/^ServerActive=127.0.0.1/ServerActive=$ZABBIX_SERVER_IP/" /etc/zabbix/zabbix_agentd.conf

# Configure hostname to use system hostname
SYSTEM_HOSTNAME=$(hostname)
execute sed -i "s/^# Hostname=/Hostname=$SYSTEM_HOSTNAME/" /etc/zabbix/zabbix_agentd.conf
execute sed -i "s/^Hostname=Zabbix server/Hostname=$SYSTEM_HOSTNAME/" /etc/zabbix/zabbix_agentd.conf

# Generating PSK and setting permissions
print_message "Generating and configuring PSK..."

# Generate or use provided PSK
if [ -n "$PSK_KEY" ]; then
    echo "$PSK_KEY" > $PSK_FILE
else
    openssl rand -hex 32 > $PSK_FILE
fi

if [ $? -ne 0 ]; then
    print_message "Failed to generate/write PSK to $PSK_FILE. Check permissions and path." "error"
    exit 1
fi
execute chmod 744 $PSK_FILE
execute sed -i "s|^# TLSConnect=unencrypted|TLSConnect=psk|" /etc/zabbix/zabbix_agentd.conf
execute sed -i "s|^# TLSAccept=unencrypted|TLSAccept=psk|" /etc/zabbix/zabbix_agentd.conf
execute sed -i "s|^# TLSPSKIdentity=|TLSPSKIdentity=$PSK_IDENTITY|" /etc/zabbix/zabbix_agentd.conf
execute sed -i "s|^# TLSPSKFile=|TLSPSKFile=$PSK_FILE|" /etc/zabbix/zabbix_agentd.conf

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
echo -e "${GREEN}Your PSK Identity is: ${YELLOW}$PSK_IDENTITY${NC}"
echo -e "${GREEN}Your PSK is: ${YELLOW}$PSK_CONTENT${NC}"