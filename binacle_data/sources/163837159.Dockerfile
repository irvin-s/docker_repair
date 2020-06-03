FROM debian:latest
MAINTAINER imlonghao <imlonghao@gmail.com>

ADD https://dl.chenyufei.info/shadowsocks/latest/shadowsocks-server-linux64-1.1.4.gz /etc/ss-server.gz
RUN gunzip /etc/ss-server.gz
RUN chmod +x /etc/ss-server

ENTRYPOINT ["/etc/ss-server"]

