#!/bin/bash

# Function to check if Docker is installed
check_docker() {
    if ! command -v docker &> /dev/null
    then
        echo "Docker could not be found. Please install Docker and try again."
        exit 1
    fi
}

# Check if Docker is installed
check_docker

# Check for command-line arguments
if [ $# -eq 2 ]; then
    # If two arguments are provided, use them as the Dockerfile path and image name
    dockerfile_input=$1
    image_name=$2
else
    # Function to ask for user input
    ask() {
        read -p "$1: " input
        echo $input
    }

    # Ask the user for the Dockerfile name or path
    dockerfile_input=$(ask "Enter the Dockerfile name or full path")

    # Ask the user for the image name
    image_name=$(ask "Enter the name for the Docker image")
fi

# Determine if the input is a filename in the current directory or a full path
if [[ "$dockerfile_input" == *"/"* ]]; then
    # Full path
    dockerfile_path=$dockerfile_input
    dockerfile_directory=$(dirname "$dockerfile_input")
else
    # Filename in the current directory
    dockerfile_directory="."
    dockerfile_path="./$dockerfile_input"
fi

# Check if the Dockerfile exists at the specified location
if [ ! -f "$dockerfile_path" ]; then
    echo "Dockerfile not found at the specified location: $dockerfile_path"
    exit 1
fi

# Build the Docker image
echo "Building Docker image '$image_name' from Dockerfile at '$dockerfile_path'..."
docker build -t $image_name -f $dockerfile_path $dockerfile_directory

# Confirm the image was built
if [ $? -eq 0 ]; then
    echo "Docker image '$image_name' built successfully."
else
    echo "Failed to build Docker image '$image_name'."
fi
