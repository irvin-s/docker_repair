# BUILDING
# docker build -t stuckless/sagetv-base:latest .

# Ubuntu 16.04
FROM phusion/baseimage:0.10.0

CMD ["/sbin/my_init"]

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

# The docker container version, not SageTV version
ENV SAGETV_CONTAINER_VERSION="1.0.4" \
    APP_NAME="SageTV Media Server" \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# add sagetv user and group
# Speed up APT
# sagetv stuff
# comskip stuff
# clean up
RUN set -x && \
    locale-gen en_US.UTF-8 && \
    useradd -u 911 -U -d /opt/sagetv -s /bin/bash -G video sagetv && \
    echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \
    echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache && \
    add-apt-repository -y universe && \
    apt-get update && \
    apt-get install -y wget curl libfaad2 net-tools file libargtable2-0 ffmpeg sudo \
        less vim software-properties-common unzip cifs-utils lirc dos2unix && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add in our System Files
COPY SYSTEM/ /

RUN chmod 755 /etc/my_init.d/* && \
    chmod 440 /etc/sudoers.d/sagetv-sudo && \
    chmod 755 /usr/bin/wine

VOLUME ["/var/media", "/var/mediaext", "/opt/sagetv"]

# Client (TCP 42024 for connecting, TCP 7818 for streaming, UDP 8270 for finding servers)
# All extenders (UDP 31100 for discovery, TCP 31099 for connections?)
# Hauppage extender (all UDP) 16867 16869 16881
# Web Server 8080
# jstatd is port 9010
EXPOSE 42024 7818 8270 31100 31099 16867 16869 16881 8080 9010
