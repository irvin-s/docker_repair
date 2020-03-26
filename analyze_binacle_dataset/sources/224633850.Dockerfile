FROM demoregistry.dataman-inc.com/library/alpine3.3-base:latest

RUN apk add --update python && rm -rf /var/cache/apk/*
