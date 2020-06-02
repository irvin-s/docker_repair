FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    cheese \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["cheese"]
