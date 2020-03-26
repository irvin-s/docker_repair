FROM ubuntu:18.04

# Build arguments
ARG symbol=SYS

# Install base dependencies
RUN apt-get update \
    && apt-get install -y git sudo

ARG telos_fork=Telos-Foundation
ARG telos_branch=master
RUN git clone -b $telos_branch https://github.com/$telos_fork/telos.git /telos
WORKDIR /telos
RUN git submodule update --init --recursive

ENV TERM xterm

RUN echo 1 | ./telos_build.sh -s $symbol
RUN cd build && sudo make install

# Done building. Set default WORKDIR.
WORKDIR /

# Environment variables
ENV SYMBOL $symbol
ENV PATH $PATH:/usr/local/eosio/bin

# Data dir
VOLUME /telos/build/data-dir
ENV DATA_DIR /telos/build/data-dir
ENV CONFIG_DIR /telos/build/data-dir

# Setup default folders and config files.
RUN mkdir -p $DATA_DIR $CONFIG_DIR
COPY ./config_telos.ini $CONFIG_DIR/config.ini
