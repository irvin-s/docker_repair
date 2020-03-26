FROM debian:stretch
MAINTAINER slush@satoshilabs.com

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV TERM linux

RUN apt-get update && \
    apt-get upgrade -qy && \
    apt-get install -qy apt-transport-https curl git && \
    apt-get install -qy gnupg && \
    echo 'deb https://deb.nodesource.com/node_4.x stretch main' | tee /etc/apt/sources.list.d/nodesource.list && \
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN apt-get update && \
    apt-get -qy install nodejs python make build-essential libzmq3-dev devscripts dh-systemd
RUN npm install -g yarn
ADD bitcore-ltc/ /root/bitcore-ltc
RUN ( cd /root/bitcore-ltc && debuild -uc -us )

