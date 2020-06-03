FROM debian:stretch

RUN set -e && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y && \
    apt-get install -y xvfb x11vnc firefox-esr git make wget sudo gnupg && \
    wget -q -O /tmp/node8 https://deb.nodesource.com/setup_8.x && \
    sudo -E bash /tmp/node8 && \
    apt-get install -y nodejs npm && \
    npm install jpm --global && \
    rm -rf /var/lib/apt/lists/*
