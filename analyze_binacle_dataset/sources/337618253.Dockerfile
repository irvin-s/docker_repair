FROM ubuntu:16.04
MAINTAINER <safe@safecoin.org>

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev \
    unzip python zlib1g-dev wget bsdmainutils automake libssl-dev libprotobuf-dev \
    protobuf-compiler libqrencode-dev libdb++-dev software-properties-common libcurl4-openssl-dev curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./ /safecoin
ENV HOME /safecoin
WORKDIR /safecoin

# configure || true or it WILL halt
RUN cd /safecoin && \
    ./autogen.sh && \
    ./configure --with-incompatible-bdb --with-gui || true && \
    ./zcutil/build.sh -j$(nproc)

# Unknown stuff goes here

RUN ln -sf /safecoin/src/safecoind /usr/bin/safecoind && \
    ln -sf /safecoin/zcutil/docker-entrypoint.sh /usr/bin/entrypoint && \
    ln -sf /safecoin/zcutil/docker-safecoin-cli.sh /usr/bin/safecoin-cli

CMD ["entrypoint"]
