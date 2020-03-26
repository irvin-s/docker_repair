FROM ubuntu:14.04

VOLUME /bitcoin

ADD ./sources.list /etc/apt/sources.list
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install git build-essential jq curl python pv

RUN cd /usr/local/src && \
    git clone https://github.com/bitcoin/bitcoin.git && \
    cd bitcoin && \
    git checkout a9149688f87cb790a600400abd9af72c3ee0c312

VOLUME /input
VOLUME /output

ADD ./mkbootstrap /usr/local/bin/mkbootstrap
RUN chmod +x /usr/local/bin/mkbootstrap

ENTRYPOINT /usr/local/bin/mkbootstrap
