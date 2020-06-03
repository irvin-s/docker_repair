FROM ubuntu:trusty
# https://github.com/jameslitton/coinscope

RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get install -y bitcoind

RUN apt-get update && \
    apt-get install -y build-essential curl jq git \
    libconfig++-dev libev-dev libboost-program-options-dev libssl-dev && \
    git clone --depth=1 https://github.com/jameslitton/coinscope.git /coinscope && \
    cd /coinscope && \
    make && \
    rm -rf /var/lib/apt/lists/*
ADD bitcoin.conf /root/.bitcoin/
WORKDIR /coinscope
RUN sed -i.bak 's/"connector"/"root"/g' netmine.cfg
ADD start.sh .
RUN chmod +x start.sh
