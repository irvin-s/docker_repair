############################################################
# Dockerfile to build cannacoind container images
# Based on Ubuntu
############################################################

FROM ubuntu:14.04
MAINTAINER laudney

RUN apt-get update
RUN apt-get install -y git make g++ python-leveldb libboost-all-dev libssl-dev libdb++-dev pkg-config libminiupnpc-dev wget xz-utils
RUN apt-get clean

RUN adduser cannacoin --disabled-password
USER cannacoin

WORKDIR /home/cannacoin
RUN mkdir bin src
RUN echo PATH=\"\$HOME/bin:\$PATH\" >> .bash_profile

WORKDIR /home/cannacoin/src
RUN git clone https://github.com/cannacoin-project/cannacoin.git

WORKDIR	/home/cannacoin/src/cannacoin/src
RUN make -f makefile.unix
RUN strip cannacoind
RUN cp -f cannacoind /home/cannacoin/bin/
RUN make -f makefile.unix clean

WORKDIR	 /home/cannacoin
RUN mkdir .cannacoin
RUN cp -f src/cannacoin/contrib/docker/cannacoin.conf .cannacoin/

WORKDIR /home/cannacoin/.cannacoin
RUN wget -q https://github.com/cannacoin-project/cannacoin/releases/download/v1.3.1.2/bootstrap.dat.xz

ENV HOME /home/cannacoin
EXPOSE 8332
USER cannacoin
