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
    apt-get install -y curl && apt-get install -y automake && \
    apt-get install -y build-essential && \
    apt-get install -y libcurl4-openssl-dev && \
    apt-get install -y libjansson-dev && \
    cd /opt/ && \
    curl -LO "https://github.com/wificoin-project/wifiminer/archive/master.zip" -H 'Cookie: from=github.com' && \
    unzip master.zip && \
    rm master.zip && \
    cd wifiminer-master && \
    ./autogen.sh && \
    ./configure && \
    make -j2 && \
    cp ./minerd /usr/bin/minerd && \
    cd ~ && rm -rf /opt/wifiminer-master && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
