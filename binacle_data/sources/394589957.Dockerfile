FROM ubuntu:14.04
MAINTAINER Antonin Hildebrand <antonin@binaryage.com>

ENV BITCOIN_DOWNLOAD_VERSION 0.9.1
ENV BITCOIN_DOWNLOAD_MD5_CHECKSUM 7a9c14c09b04e3e37d703fbfe5c3b1e2

RUN apt-get update
RUN apt-get install -y wget build-essential make g++ python-leveldb libboost-all-dev libssl-dev libdb++-dev libtool autotools-dev autoconf libboost-all-dev bsdmainutils pkg-config

WORKDIR /tmp
RUN wget --no-check-certificate https://github.com/bitcoin/bitcoin/archive/v$BITCOIN_DOWNLOAD_VERSION.tar.gz

RUN echo "$BITCOIN_DOWNLOAD_MD5_CHECKSUM  v$BITCOIN_DOWNLOAD_VERSION.tar.gz" | md5sum -c -
RUN tar xfz v$BITCOIN_DOWNLOAD_VERSION.tar.gz && mv bitcoin-$BITCOIN_DOWNLOAD_VERSION bitcoin

WORKDIR /tmp/bitcoin
RUN ./autogen.sh
RUN ./configure --disable-wallet
RUN make
RUN make install

ADD . /bitcoind
WORKDIR /bitcoind

EXPOSE 8333
EXPOSE 8332

ADD	enter /enter
RUN	chmod +x /enter

# just a check that bitcoind exists on path
RUN file `which bitcoind`

ENTRYPOINT ["/enter"]
