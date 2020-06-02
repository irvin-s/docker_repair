FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    curl \
    --no-install-recommends && \ 
    rm -rf /var/lib/apt/lists/* 

RUN curl -sSL https://github.com/hypriot/x11-on-HypriotOS/raw/master/install-chromium-browser.sh | bash

ENTRYPOINT ["chromium-browser"]

