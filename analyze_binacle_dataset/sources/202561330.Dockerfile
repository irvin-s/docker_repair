FROM resin/rpi-raspbian:jessie
#FROM hypriot/rpi-node

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    build-essential \
    git \
    nodejs \
    nodejs-legacy \
    npm \
    redis-server \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN git clone git://github.com/adafruit/Adafruit-WebIDE.git && \
    cd Adafruit-WebIDE && \
    mkdir tmp && \
    npm config set tmp tmp && \
    npm install
    #editor config/config.js (change port 80 to your port of choice)

ENTRYPOINT ["nodejs", "server.js"]
     
