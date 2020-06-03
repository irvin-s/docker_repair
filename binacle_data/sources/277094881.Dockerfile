FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y -qq upgrade && \
    apt-get -y -qq install software-properties-common && \
    add-apt-repository ppa:ethereum/ethereum && \
    apt-get update && \
    apt-get -y -qq install geth solc && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#FROM ethereum/client-go:latest
#
#RUN apk update &&\
#  apk add bash perl

COPY bin/* /root/

RUN chmod +x /root/*.sh

ENTRYPOINT ["geth"]