# sudo make me a sandwich

FROM alpine:latest

MAINTAINER Erik Falor <ewfalor@gmail.com>

RUN apk add --update sudo make curl && rm -rf /var/cache/apk/*

ADD Makefile README.md /

ENTRYPOINT ["sh"]
