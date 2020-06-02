FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    wget \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate \
    http://download.processing.org/processing-3.0.2-linux-armv6hf.tgz && \
    tar xvfz processing-3.0.2-linux-armv6hf.tgz && \
    rm processing-3.0.2-linux-armv6hf.tgz

ENTRYPOINT ["/processing-3.0.2/processing"]
