# EXA BGP
#
# Commit version to be use [ bb7d1b7b539a48ca331c05a474f1af6015424273 ]

FROM ubuntu:14.04

MAINTAINER Naoto Hanaue <hanaue.naoto@po.ntts.co.jp>

RUN apt-get update
RUN apt-get install -qy --no-install-recommends wget python git

ENV HOME /root
WORKDIR /root

RUN wget --no-check-certificate https://github.com/Exa-Networks/exabgp/archive/3.4.11.tar.gz
RUN mkdir exabgp && tar xzvf 3.4.11.tar.gz -C exabgp --strip-components 1

ADD exabgp.env /root/exabgp/etc/exabgp/exabgp.env
