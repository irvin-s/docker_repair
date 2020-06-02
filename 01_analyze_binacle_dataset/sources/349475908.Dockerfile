FROM alpine:edge
RUN apk add --update \
  --repository http://dl-3.alpinelinux.org/alpine/edge/testing \
  vips-tools \
  && rm -rf /var/cache/apk/*
