#
# Dockerfile for shadowsocks-go
#

FROM alpine
MAINTAINER xzdbd <xzdbd@sina.com>

ENV SS_VER 1.1.5
ENV SS_URL https://github.com/shadowsocks/shadowsocks-go/releases/download/1.1.5/shadowsocks-server-linux64-$SS_VER.gz
ENV SERVER_PORT 8388
ENV PASSWORD password
ENV METHOD aes-128-cfb
ENV TIMEOUT 600

# COPY ./config.json /opt/ss-config.json

ADD $SS_URL /opt/shadowsocks-server.gz

WORKDIR /opt

RUN gzip -d /opt/shadowsocks-server.gz && chmod +x /opt/shadowsocks-server

EXPOSE $SERVER_PORT

CMD /opt/shadowsocks-server -p $SERVER_PORT -k $PASSWORD -m $METHOD -t $TIMEOUT -u