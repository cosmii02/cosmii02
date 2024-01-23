# Use the official Ubuntu base image
FROM debian:latest

# Label the image
LABEL maintainer="cosmii02@cosmii02.com"
LABEL description="Debian image customized for cosmii"

# Avoid prompts from apt
ARG DEBIAN_FRONTEND=noninteractive

# Update apt cache, upgrade all packages, and install wget, curl, and whiptail
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        wget \
        curl \
        whiptail \
    # Clean up apt cache to reduce image size
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Use /bin/bash as entry point
ENTRYPOINT ["/bin/bash"]
