FROM ubuntu:16.04
MAINTAINER rench <185656156@qq.com>
ENV LANG en_US.UTF-8
RUN sed -i -e 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list && \
    sed -i -e 's/deb http:\/\/security/#deb http:\/\/security/' /etc/apt/sources.list && \
    sed -i -e 's/deb-src http:\/\/security/#deb-src http:\/\/security/' /etc/apt/sources.list && \
    echo "Asia/Shanghai" > /etc/timezone && \
    unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    export LC_ALL=C && \
    apt-get update && \
    apt-get install tzdata && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get install -y libboost-system1.58-dev && \
    apt-get install -y libboost-filesystem1.58-dev && \
    apt-get install -y libboost-program-options1.58-dev && \
    apt-get install -y libboost-thread1.58-dev && \
    apt-get install -y libdb4.8-dev libdb4.8++-dev && \
    apt-get install -y libminiupnpc-dev && \
    apt-get install -y libevent-dev && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
