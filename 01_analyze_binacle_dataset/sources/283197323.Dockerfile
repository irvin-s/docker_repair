FROM ubuntu:16.04

LABEL version="1.0"
LABEL maintainer="shindu666@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --yes software-properties-common
RUN add-apt-repository ppa:ethereum/ethereum
RUN apt-get update && apt-get install --yes geth

RUN adduser --disabled-login --gecos "" eth_user

COPY eth_common /home/eth_user/eth_common
RUN chown -R eth_user:eth_user /home/eth_user/eth_common

USER eth_user

WORKDIR /home/eth_user

RUN geth init eth_common/genesis.json

ENTRYPOINT bash

