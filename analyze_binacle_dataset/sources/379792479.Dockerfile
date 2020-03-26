FROM ubuntu:xenial

# MINIMAL VERSION
# docker build -t openresty-minimal .
# docker run --name=openresty-minimal -v /home/irocha:/mnt/irocha -it -p 8080:8080 openresty-minimal /bin/bash
# docker run --name=openresty-minimal -v /home/irocha:/mnt/irocha -it -p 8080:8080 openresty-minimal nginx -c /mnt/irocha/git/lua-labs/openresty/docker/openresty-minimal/test/nginx.conf
# docker exec -it openresty-minimal /bin/bash
# docker logs -f openresty-minimal
# docker stop openresty-minimal
# docker ps -a --no-trunc| grep '\''Exit'\'' | awk '\''{print $1}'\'' | xargs -L 1 -r docker rm'
# docker inspect openresty-minimal|grep -i logpath | awk -F\" '{print $4}'|xargs sudo tail -f
# curl -v http://localhost:8080/test?b=irr%202014

MAINTAINER Ivan Ribeiro Rocha <ivan.ribeiro@gmail.com>

ENV OPENRESTY_VERSION 1.9.15.1

RUN mkdir -p /opt/lua

ADD packages/openresty.tar.gz /opt/lua
ADD packages/test-nginx.tar.gz /opt/lua

COPY bin /usr/local/bin
COPY root /root/

RUN cat /root/bash.bashrc >> /etc/bash.bashrc && rm -rf /root/bash.bashrc \
    && sed -i.bak -e 's/archive.ubuntu.com/br.archive.ubuntu.com/g' /etc/apt/sources.list \
    && rm -rf /etc/apt/sources.list.bak; apt-get update -y \
    && apt-get install -y vim wget unzip telnet curl bash-completion sipcalc nmap netcat-openbsd \
                       tcpstat sysstat dstat htop strace ltrace lsof make net-tools iputils-ping \
                       cpanminus libtext-diff-perl libtest-longstring-perl \
                       liblist-moreutils-perl libtest-base-perl \
                       liblwp-useragent-determined-perl \
                       geoip-bin geoip-database \
    && cd /opt/lua/test-nginx && perl Makefile.PL && make && make install && cd .. && rm -rf test-nginx \
    && ln -sf /opt/lua/openresty/nginx/sbin/nginx /usr/local/bin/nginx \
    && ln -sf /usr/local/bin/nginx /usr/local/bin/openresty \
    && ln -sf /opt/lua/openresty/bin/resty /usr/local/bin/resty \
    && ln -sf /opt/lua/openresty/luajit/bin/luajit-2.1.0-beta2 /opt/lua/openresty/luajit/bin/lua \
    && ln -sf /opt/lua/openresty/luajit/bin/lua /usr/local/bin/lua \
    && ln -sf /opt/lua/openresty /usr/local/openresty \
    && ln -sf /opt/lua/openresty /usr/local/openresty-debug \
    && echo "/opt/lua/openresty/luajit/lib" > /etc/ld.so.conf.d/luajit.conf
