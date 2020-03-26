FROM alpine:latest
MAINTAINER thanos_me <thanosme@totallynoob.com>


RUN apk add --no-cache --update wget \
 && wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v0.8.1/frp_0.8.1_linux_amd64.tar.gz \
 && tar zxvf frp_0.8.1_linux_amd64.tar.gz \
 && mv frp_0.8.1_linux_amd64/frps /usr/local/bin/ \
 && rm -r frp_0.8.1_linux_amd64* \
 && chmod +x /usr/local/bin/frps

VOLUME /data
ENTRYPOINT ["/usr/local/bin/frps", "-L", "console", "-c", "/data/frps.ini"]
