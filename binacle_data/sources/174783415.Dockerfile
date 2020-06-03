FROM centos:centos6

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum install -y wget tar gcc zlib zlib-devel openssl openssl-devel unzip mysql-devel python-devel which gcc-c++

ENV LANG en_US.UTF-8

RUN mkdir -p /usr/src/nodejs
WORKDIR /usr/src/nodejs

ENV NODEJS_VERSION 0.11.14
RUN curl -SL "http://dist.u.qiniudn.com/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}.tar.gz" | tar xzf - --strip-components=1
RUN ./configure \
    && make \
    && make install \
    && make clean

ADD . /opt/
WORKDIR /opt

RUN tar zxvf scribed.tar.gz \
    && chown -R root:root scribed \
    && rm -f scribed.tar.gz

RUN curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python
RUN pip install supervisor \
    && echo_supervisord_conf > /etc/supervisord.conf \
    && echo "[include]" >> /etc/supervisord.conf \
    && echo "files = /etc/supervisord.d/*.conf" >> /etc/supervisord.conf \
    && mkdir -p /etc/supervisord.d \
    && cp nodejs.conf scribed.conf /etc/supervisord.d/ \
    && rm -f nodejs.conf scribed.conf Dockerfile

RUN npm install -g cnpm --registry=http://r.cnpmjs.org
RUN mkdir -p /opt/logs

