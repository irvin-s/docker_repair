FROM ubuntu:xenial

# MINIMAL VERSION
# docker build -t redisproxy-resty .
# docker run --name=redisproxy-resty -it -p 8080:8080 -e REDIS_SERVICE_HOST=172.22.33.140 -e REDIS_SERVICE_PORT=6379 redisproxy-resty
# docker exec -it redisproxy-resty /bin/bash
# docker logs -f redisproxy-resty
# docker stop redisproxy-resty
# docker ps -a --no-trunc| grep '\''Exit'\'' | awk '\''{print $1}'\'' | xargs -L 1 -r docker rm'
# docker inspect redisproxy-resty|grep -i logpath | awk -F\" '{print $4}' | xargs sudo tail -f

MAINTAINER Ivan Ribeiro Rocha <ivan.ribeiro@gmail.com>

ENV OPENRESTY_VERSION 1.9.15.1

RUN mkdir -p /opt/lua/redisproxy-resty

WORKDIR /opt/lua/redisproxy-resty

ADD packages/openresty.tar.gz /opt/lua
ADD packages/test-nginx.tar.gz /opt/lua

COPY bin /usr/local/bin
COPY root /root/

COPY dump.lua /opt/lua/redisproxy-resty/
COPY proxy.lua /opt/lua/redisproxy-resty/
COPY nginx.conf /opt/lua/redisproxy-resty/

RUN cat /root/bash.bashrc >> /etc/bash.bashrc && rm -rf /root/bash.bashrc \
    && sed -i.bak -e 's/archive.ubuntu.com/br.archive.ubuntu.com/g' /etc/apt/sources.list \
    && rm -rf /etc/apt/sources.list.bak; apt-get update -y \
    && apt-get install -y libssl-dev vim wget unzip telnet curl bash-completion sipcalc nmap netcat-openbsd \
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

EXPOSE 8080

CMD [ "nginx", "-c", "/opt/lua/redisproxy-resty/nginx.conf" ]
