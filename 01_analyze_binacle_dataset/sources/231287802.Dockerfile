FROM ubuntu
# FROM amd64=ubuntu:16.04 arm64=aarch64/ubuntu:16.04 arm=armhf/ubuntu:16.04

RUN apt-get update \
    && apt-get install -y build-essential pkg-config wget bison \
       flex iptables-dev libnftnl-dev libmnl-dev gperf libglib2.0-dev \
       libkmod-dev uuid-dev libblkid-dev autoconf automake libtool libssl-dev nasm perl attr-dev

COPY bin/strato /sbin/
COPY assets/repositories-build /etc/strato/repositories
COPY assets/install-deb /usr/bin/install-deb
RUN mkdir -p /var/lib/strato && touch /var/lib/strato/packages
