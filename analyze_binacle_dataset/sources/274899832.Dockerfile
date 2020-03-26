FROM buildpack-deps:jessie
MAINTAINER Ian Patton (ian.patton@gmail.com)

ENV BITCOIN_DATA=/data
ENV CONFIG_DIR=/home/ows/config

RUN mkdir -p $BITCOIN_DATA
RUN mkdir -p $CONFIG_DIR

COPY default.bitcoin.conf $BITCOIN_DATA/bitcoin.conf
COPY default.bch-node.json $CONFIG_DIR/bch-node.json
COPY default.bch-node.conf $CONFIG_DIR/bitcoin.conf

CMD ["echo","installed config files"]
