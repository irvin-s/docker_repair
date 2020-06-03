FROM ubuntu:14.04
MAINTAINER Harsh Vakharia <harshjv@gmail.com>

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y wget

ADD https://raw.githubusercontent.com/harshjv/docker-texlive-2015/master/install-tl-ubuntu install-tl-ubuntu
RUN chmod +x install-tl-ubuntu

RUN ./install-tl-ubuntu

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
           /tmp/* \
           /var/tmp/*

ENV PATH /opt/texbin:$PATH

VOLUME /var/texlive

WORKDIR /var/texlive
