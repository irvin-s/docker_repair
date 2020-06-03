FROM phusion/baseimage:0.9.19
MAINTAINER The bitshares decentralized organisation

ENV LANG=en_US.UTF-8

ADD . /bitshares-core
WORKDIR /bitshares-core

RUN \
    apt-get update -y && \
    apt-get install -y \
      g++ \
      autoconf \
      cmake \
      git \
      libbz2-dev \
      libreadline-dev \
      libboost-all-dev \
      libcurl4-openssl-dev \
      libssl-dev \
      libncurses-dev \
      doxygen \
      libcurl4-openssl-dev \
      fish && \
    #
    # Obtain version
    echo && echo '------ Obtain version ------' && \
    mkdir -v  /etc/bitshares /var/lib/bitshares && \
    git submodule update --init --recursive && \
    git rev-parse --short HEAD > /etc/bitshares/version && \

    #
    # Default exec/config files
    echo && echo '------ Default exec/config files ------' && \
    cp -fv docker/default_config.ini /var/lib/bitshares/config.ini && \
    cp -fv docker/bitsharesentry.sh /usr/local/bin/bitsharesentry.sh && \
    chmod -v a+x /usr/local/bin/bitsharesentry.sh && \

    #
    # Compile
    echo && echo '------ Compile ------' && \
    cmake  \
      -DCMAKE_BUILD_TYPE=Release \
      . && \
    make karma && \
    make install && \
    cd / && \
    rm -rf /bitshares-core && \
    apt-get autoremove -y --purge g++ gcc autoconf cmake libboost-all-dev doxygen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Home directory $HOME
WORKDIR /
ENV HOME /var/lib/bitshares

# Volume
VOLUME ["/var/lib/bitshares"]

# rpc service:
EXPOSE 8090
# p2p service:
EXPOSE 5678

# default execute entry
CMD /usr/local/bin/bitsharesentry.sh
