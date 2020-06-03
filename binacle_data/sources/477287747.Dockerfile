FROM alpine
MAINTAINER keepwn <keepwn@gmail.com>

RUN apk update && \
    apk add git make go openssl && \
    rm -rf /var/cache/apk/*

ADD build.sh /
RUN chmod +x /build.sh

ENV DOMAIN **None**
ENV TUNNEL_PORT 4443
ENV HTTP_PORT 80
ENV HTTPS_PORT 443

VOLUME ["/release"]

CMD ["/build.sh"]
