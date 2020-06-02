FROM node:10.15-stretch

MAINTAINER Marco Raddatz

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Install dependencies and tools
RUN apt-get update; \
    apt-get install -y apt-utils apt-transport-https; \
    apt-get install -y curl wget; \
    apt-get install -y libnss-mdns avahi-discover libavahi-compat-libdnssd-dev libkrb5-dev; \
    apt-get install -y ffmpeg; \
    apt-get install -y nano vim

# Install latest Homebridge
# -------------------------------------------------------------------------
# You can force a specific version by setting HOMEBRIDGE_VERSION
# See https://github.com/marcoraddatz/homebridge-docker#homebridge_version
# -------------------------------------------------------------------------
RUN npm install -g homebridge --unsafe-perm

# MISC settings
COPY avahi-daemon.conf /etc/avahi/avahi-daemon.conf

USER root
RUN mkdir -p /var/run/dbus

ADD image/run.sh /root/run.sh

# Run container
EXPOSE 5353 51826
CMD ["/root/run.sh"]
