FROM alpine:3.5

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.bwa="0.7.15" \
      version.alpine="3.5.x" \
      source.bwa="https://github.com/lh3/bwa/releases/tag/v0.7.15"

ENV TOOL_VERSION 0.7.15

RUN apk add --update --no-cache ncurses \
      && apk add --virtual=deps --update --no-cache musl-dev zlib-dev make gcc \
      && apk add ca-certificates openssl \
      && cd /tmp && wget https://github.com/lh3/bwa/releases/download/v${TOOL_VERSION}/bwa-${TOOL_VERSION}.tar.bz2 \
      && tar xjvf bwa-${TOOL_VERSION}.tar.bz2 \
      && cd /tmp/bwa-${TOOL_VERSION} \
      && sed -i[.bak] '1i#include <stdint.h>' kthread.c \
      && sed -i[.bak] "s/u_int32_t/uint32_t/g" *.c \
      && sed -i[.bak] "s/u_int32_t/uint32_t/g" *.h \
      && make \
      && mv /tmp/bwa-${TOOL_VERSION}/bwa /usr/bin \
      && rm -rf /var/cache/apk/* /tmp/* \
      && apk del deps

ENTRYPOINT ["/usr/bin/bwa"]
