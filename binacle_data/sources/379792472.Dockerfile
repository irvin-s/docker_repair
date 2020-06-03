FROM ubuntu:trusty

# BUILD VERSION
# docker build -t openresty-build .
# docker run --name=openresty-build -it -p 8080:8080 openresty-build /bin/bash

MAINTAINER Ivan Ribeiro Rocha <ivan.ribeiro@gmail.com>

ENV OPENRESTY_VERSION 1.9.15.1

RUN mkdir -p /opt/lua/base

COPY root /root/
COPY lua /opt/lua/base/

RUN cat /root/bash.bashrc >> /etc/bash.bashrc && rm -rf /root/bash.bashrc \
    && sed -i.bak -e 's/archive.ubuntu.com/br.archive.ubuntu.com/g' /etc/apt/sources.list \
    && rm -rf /etc/apt/sources.list.bak; apt-get update -y \
    && apt-get install -y vim wget unzip telnet curl cron supervisor logrotate httpie glances \
                       bash-completion iputils-arping git sipcalc nmap netcat-openbsd \
                       tcpstat sysstat dstat htop strace ltrace lsof scons valgrind net-tools iputils-ping \
                       make build-essential libreadline6-dev libpcre3-dev libssl-dev \
                       libsqlite3-dev libmysqlclient-dev libexpat1-dev \
                       cpanminus libtext-diff-perl libtest-longstring-perl \
                       liblist-moreutils-perl libtest-base-perl \
                       liblwp-useragent-determined-perl \
                       libgeoip-dev geoip-bin geoip-database \
    && cd /opt/lua \
    && wget -qO- http://openresty.org/download/openresty-1.9.15.1.tar.gz | tar xvz -C /opt/lua/ \
    && cd /opt/lua/openresty-1.9.15.1 \
    && ./configure --prefix=/opt/lua/openresty \
            --with-http_gunzip_module \
            --with-luajit \
            --with-http_geoip_module \
            --with-http_realip_module \
            --with-http_iconv_module \
            --with-http_stub_status_module \
            --with-http_ssl_module \
            --with-http_realip_module \
            --with-http_v2_module \
            --with-md5-asm \
            --with-sha1-asm \
            --with-file-aio \
            --with-stream \
            --with-stream_ssl_module \
            --without-http_fastcgi_module \
            --without-http_uwsgi_module \
            --without-http_scgi_module \
            --with-debug \
    && make install && cd .. && rm -rf nginx_tcp_proxy_module ngx_openresty-1.7.10.1 \
    && cd /opt/lua \
    && git clone https://github.com/openresty/test-nginx.git && cd test-nginx \
    && perl Makefile.PL && make && make install && cd .. && rm -rf test-nginx \
    && git clone https://github.com/irr/sockproc.git && cd sockproc \
    && make && mv sockproc /usr/local/bin/ && cd .. && rm -rf sockproc \
    && ln -sf /opt/lua/openresty/nginx/sbin/nginx /usr/local/bin/nginx \
    && ln -sf /usr/local/bin/nginx /usr/local/bin/openresty \
    && ln -sf /opt/lua/openresty/bin/resty /usr/local/bin/resty \
    && ln -sf /opt/lua/openresty/luajit/bin/luajit-2.1.0-beta2 /opt/lua/openresty/luajit/bin/lua \
    && ln -sf /opt/lua/openresty/luajit/bin/lua /usr/local/bin/lua \
    && ln -sf /opt/lua/openresty /usr/local/openresty \
    && ln -sf /opt/lua/openresty /usr/local/openresty-debug \
    && wget -qO- http://luarocks.org/releases/luarocks-2.2.0.tar.gz | tar xvz -C /tmp/ \
    && cd /tmp/luarocks-* \
    && ./configure --with-lua=/opt/lua/openresty/luajit \
        --with-lua-include=/opt/lua/openresty/luajit/include/luajit-2.1 \
        --with-lua-lib=/opt/lua/openresty/lualib \
    && make && make install \
    && rm -rf /tmp/luarocks-* \
    && echo "/opt/lua/openresty/luajit/lib" > /etc/ld.so.conf.d/luajit.conf
