FROM ubuntu:14.04

MAINTAINER Wataru Ishida <ishida.wataru@lab.ntt.co.jp>

ENV HOME /root
WORKDIR /root

RUN apt-get update
RUN apt-get install -qy --no-install-recommends wget tar gcc flex bison libncurses-dev libreadline6-dev make
RUN wget ftp://bird.network.cz/pub/bird/bird-1.5.0.tar.gz && tar xvf bird-1.5.0.tar.gz && cd bird-1.5.0 && ./configure && make && make install
