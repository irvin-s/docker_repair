# Base docker image
FROM node:6.5.0

ENV BUILD_NAME=surf

RUN npm install -g surf-build@1.0.2 electron-forge@2.8.1

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    git \
    fakeroot \
    clang \
    cmake \
    libgnome-keyring-dev \
    libnss3 \
    libgtk2.0-dev \
    libnotify-dev \
    libdbus-1-dev \
    libxrandr-dev \
    libxext-dev \
    libxss-dev \
    libgconf2-dev \
    libasound2-dev \
    libcap-dev \
    libcups2-dev \
    libXtst-dev \
    libcurl4-openssl-dev \
    libxkbfile-dev \
    xauth xorg openbox lightdm \
    curl \
    wget \
    xvfb \
    rpm \
    --no-install-recommends

## NB: npm post-install hates running as root :-/
RUN useradd -ms /bin/bash surf

ENV HOME=/home/surf
USER surf

ENV SURF_REPO=https://github.com/paulcbetts/trickline
CMD surf-run -n 'surf-docker' -r 'https://github.com/paulcbetts/trickline'
