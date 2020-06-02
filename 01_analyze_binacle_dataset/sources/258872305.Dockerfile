FROM ubuntu:14.04

MAINTAINER Wataru Ishida <ishida.wataru@lab.ntt.co.jp>

RUN apt-get update
RUN apt-get install -qy --no-install-recommends bird
RUN mkdir /run/bird

ENV HOME /root
WORKDIR /root
