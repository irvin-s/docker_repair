FROM mitchtech/rpi-x11-apps
#FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    libreoffice \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

CMD ["libreoffice"]
