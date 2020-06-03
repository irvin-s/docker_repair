FROM openresty-minimal

# DEV VERSION
# docker build -t openresty .
# docker run --name=openresty -v /home/irocha:/mnt/irocha -it -p 8080:8080 openresty /bin/bash

MAINTAINER Ivan Ribeiro Rocha <ivan.ribeiro@gmail.com>

ENV OPENRESTY_VERSION 1.9.15.1

RUN mkdir -p /opt/lua/base

COPY lua /opt/lua/base/
COPY root /root/

RUN cat /root/bash.bashrc >> /etc/bash.bashrc && rm -rf /root/bash.bashrc \
    && apt-get update -y && apt-get install -y git cron supervisor logrotate httpie glances \
                       scons valgrind build-essential libreadline6-dev libpcre3-dev libssl-dev \
                       libsqlite3-dev libmysqlclient-dev libexpat1-dev \
    && wget -qO- http://luarocks.org/releases/luarocks-2.2.0.tar.gz | tar xvz -C /tmp/ \
    && cd /tmp/luarocks-* \
    && ./configure --with-lua=/opt/lua/openresty/luajit \
        --with-lua-include=/opt/lua/openresty/luajit/include/luajit-2.1 \
        --with-lua-lib=/opt/lua/openresty/lualib \
    && make && make install \
    && rm -rf /tmp/luarocks-*
