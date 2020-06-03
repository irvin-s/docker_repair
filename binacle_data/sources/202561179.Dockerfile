FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    apt-file \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN apt-file update

CMD ["bash"]
