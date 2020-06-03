#
# Dockerfile for shadowsocksr
#

FROM python:2.7
MAINTAINER xzdbd <xzdbd@sina.com>

ENV SERVER_PORT 8388
ENV PASSWORD password
ENV METHOD aes-128-cfb
ENV PROTOCOL origin
ENV OBFS http_simple
ENV TIMEOUT 600

RUN git clone https://github.com/shadowsocksr/shadowsocksr.git

WORKDIR /shadowsocksr

RUN bash initcfg.sh

EXPOSE $SERVER_PORT

CMD python /shadowsocksr/shadowsocks/server.py