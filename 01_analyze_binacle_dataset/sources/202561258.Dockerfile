FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    epiphany-browser \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["epiphany-browser"]
