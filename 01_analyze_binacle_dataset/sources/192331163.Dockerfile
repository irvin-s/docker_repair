FROM ubuntu:14.04

MAINTAINER YanMing, yanming02@baidu.com

COPY . /opt/proxy/src/
COPY sources.list /etc/apt/sources.list

RUN apt-get update && \
 apt-get install -y --no-install-recommends libc6-dev gcc make autoconf automake libtool&& \
 rm -rf /var/lib/apt/lists/* && \
 cd /opt/proxy/src && \
 autoreconf -fvi && ./configure --enable-debug=full && make && \
 mkdir -p /opt/proxy/bin && mkdir -p /opt/proxy/conf && mkdir -p /opt/proxy/log && \
 cp /opt/proxy/src/src/nutcracker /opt/proxy/bin/ && \
 cp /opt/proxy/src/src/lua /opt/proxy/bin/ -r

COPY entrypoint.sh .
COPY nutcracker.yml /opt/proxy/conf/

ENTRYPOINT [ "./entrypoint.sh" ]
