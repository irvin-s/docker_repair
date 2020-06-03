FROM ubuntu:12.10
MAINTAINER Antonin Hildebrand <antonin@binaryage.com>

RUN apt-get update
RUN apt-get install -y wget make g++ python-leveldb libboost-all-dev libssl-dev libdb++-dev
RUN wget http://sourceforge.net/projects/bitcoin/files/Bitcoin/bitcoin-0.8.6/bitcoin-0.8.6-linux.tar.gz
RUN tar xfz bitcoin-0.8.6-linux.tar.gz
RUN cd bitcoin-0.8.6-linux/src/src && make USE_UPNP= -f makefile.unix
RUN ln -s /bitcoin-0.8.6-linux/src/src/bitcoind /bin/bitcoind

ADD . /bitcoind
WORKDIR /bitcoind

EXPOSE 8333
EXPOSE 8332

ADD	enter /enter
RUN	chmod +x /enter
ENTRYPOINT ["/enter"]