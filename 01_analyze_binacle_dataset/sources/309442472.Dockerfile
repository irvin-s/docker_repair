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
    apt-get update && apt-get install unzip  && \
    apt-get install tzdata && \
    apt-get install -y curl && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get install -y build-essential libtool autotools-dev autoconf pkg-config libssl-dev libevent-dev && \
    apt-get install -y libboost-all-dev && \
    apt-get install -y libdb4.8-dev libdb4.8++-dev && \
    apt-get install -y libminiupnpc-dev && \
    apt-get install -y libprotobuf-dev protobuf-compiler && \
    apt-get install -y libqrencode-dev && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN export LC_ALL=C && \
    cd /opt/ && \
    curl -LO "https://github.com/wificoin-project/wificoin/archive/master.zip" -H 'Cookie: from=github.com' && \
    unzip master.zip && \
    rm master.zip && \
    cd wificoin-master && \
    ./autogen.sh && \
    ./configure --disable-tests && \
    make -j2 && \
    mkdir /opt/wificoin && \
    cp ./src/wificoind /usr/bin/wificoind && \
    cp ./src/wificoin-tx /usr/bin/wificoin-tx && \
    cp ./src/wificoin-cli /usr/bin/wificoin-cli && \
    rm -rf /opt/wificoin-master
CMD ["wificoind"]