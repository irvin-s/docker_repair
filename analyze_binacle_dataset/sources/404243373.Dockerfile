FROM ubuntu:xenial

RUN set -e && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y && \
    apt-get install -y xvfb x11vnc nodejs nodejs-legacy npm git make wget && \
    npm install jpm --global && \
    rm -rf /var/lib/apt/lists/*
