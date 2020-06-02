FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    wget \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate \
    https://s3.amazonaws.com/assets.minecraft.net/pi/minecraft-pi-0.1.1.tar.gz && \
    tar xvf minecraft-pi-0.1.1.tar.gz && \
    rm minecraft-pi-0.1.1.tar.gz && \
    cd mcpi 

CMD ["minecraft-pi"]
