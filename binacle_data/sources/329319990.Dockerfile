FROM alpine:3.2

MAINTAINER Pan Jiabang <panjiabang@gmail.com> 

COPY ./config.json /tmp/shadowsocks-config.json
ADD http://dl.chenyufei.info/shadowsocks/1.1.4/shadowsocks-server-linux64-1.1.4.gz /tmp/shadowsocks-server.gz
WORKDIR /tmp/
RUN gzip -d shadowsocks-server.gz && chmod +x ./shadowsocks-server

EXPOSE 8388

# Start Nginx and with dockerize
CMD ["/tmp/shadowsocks-server", "-c", "/tmp/shadowsocks-config.json"]
