FROM alpine:latest
MAINTAINER Ivan Pedrazas <ipedrazas@gmail.com>

RUN apk add --update bash && rm -rf /var/cache/apk/*

ADD pingredis /

CMD ["/pingredis"]
