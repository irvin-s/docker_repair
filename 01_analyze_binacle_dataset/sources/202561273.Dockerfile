FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    bridge-utils \
    hostapd \
    hostap-utils \
    iw \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN echo "DAEMON_CONF=/etc/hostapd/hostapd.conf" >> /etc/init.d/hostapd

ADD hostapd.conf /etc/hostapd/hostapd.conf

#EXPOSE 67 

ENTRYPOINT ["bash"]
