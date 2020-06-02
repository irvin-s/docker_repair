FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    dnsmasq \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ADD dnsmasq.conf /etc/dnsmasq.conf

EXPOSE 67 

ENTRYPOINT ["dnsmasq","-d"]
