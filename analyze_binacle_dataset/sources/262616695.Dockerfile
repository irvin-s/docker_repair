FROM ubuntu:16.04

ENV COTURN_VERSION="4.5.0.7"

# RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    emacs-nox \
    build-essential \
    libssl-dev sqlite3 \
    libsqlite3-dev \
    libevent-dev \
    g++ \
    libboost-dev \
    libevent-dev \
    wget

RUN mkdir -p /root/build

RUN cd /root/build \    
    && wget -O coturn.tar.gz "https://github.com/coturn/coturn/archive/$COTURN_VERSION.tar.gz" \
    && tar xvf coturn.tar.gz \    
    && cd "/root/build/coturn-$COTURN_VERSION" \
    && ./configure \
    && make \
    && make install \
    && make clean \
    && apt-get clean \
    && apt-get autoclean

CMD turnserver