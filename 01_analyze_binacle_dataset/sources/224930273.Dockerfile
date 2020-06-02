FROM alpine:edge

# openjdk-8-base no contains GUI support.
RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
  && echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
  && apk update && apk upgrade \
  && apk add ca-certificates openjdk8-jre-base@community \
  && rm -rf /tmp/* /var/cache/apk/*
