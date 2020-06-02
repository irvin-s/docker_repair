#
# Dockerfile for shadowsocks-go
#

FROM alpine
MAINTAINER xzdbd <xzdbd@sina.com>

ENV SS_VER 1.2.1
ENV SS_URL https://github.com/shadowsocks/shadowsocks-go/releases/download/$SS_VER/shadowsocks-server.tar.gz
ENV SERVER_PORT 8388
ENV PASSWORD password
ENV METHOD aes-128-cfb
ENV TIMEOUT 600

ADD $SS_URL /opt/shadowsocks-server.tar.gz

WORKDIR /opt

RUN tar xvzf /opt/shadowsocks-server.tar.gz && chmod +x /opt/shadowsocks-server

EXPOSE $SERVER_PORT

CMD /opt/shadowsocks-server -p $SERVER_PORT -k $PASSWORD -m $METHOD -t $TIMEOUT -u