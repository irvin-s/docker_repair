FROM debian:stretch
MAINTAINER slush@satoshilabs.com

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV TERM linux

RUN apt-get update && \
    apt-get upgrade -qy && \
    apt-get install -qy apt-transport-https curl git wget libzmq3-dev && \
    apt-get install -qy gnupg && \
    echo 'deb https://deb.nodesource.com/node_4.x stretch main' | tee /etc/apt/sources.list.d/nodesource.list && \
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN apt-get update && \
    apt-get -qy install nodejs python make build-essential devscripts dh-systemd
RUN apt-get -qy install pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git zlib1g-dev wget bsdmainutils automake
RUN npm install -g yarn
ADD bitcore-zec/ /root/bitcore-zec
RUN ( cd /root/bitcore-zec && debuild -uc -us )

