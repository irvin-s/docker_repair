FROM alpine:3.8

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.bwa="0.7.5a" \
      version.alpine="3.8" \
      source.bwa="https://github.com/lh3/bwa/releases/tag/0.7.5a"

ENV BWA_VERSION 0.7.5a

RUN apk add --update \
      # install build tools and dependencies
            && apk add --virtual=deps --update --no-cache build-base musl-dev zlib-dev \
      # install openssl and certificates for wget
            && apk add ca-certificates openssl \
      # download and unzip bwa
            && cd /tmp && wget https://github.com/lh3/bwa/archive/${BWA_VERSION}.zip \
            && unzip ${BWA_VERSION}.zip \
      # alpine-specific data types
            && cd /tmp/bwa-${BWA_VERSION} \
            && sed -i[.bak] "s/u_int32_t/uint32_t/g" *.c \
            && sed -i[.bak] "s/u_int32_t/uint32_t/g" *.h \
      # build
            && make \
      # move binaries to /usr/bin
            && mv /tmp/bwa-${BWA_VERSION}/bwa /usr/bin \
      # clean up
            && rm -rf /var/cache/apk/* /tmp/* \
            && apk del deps

ENTRYPOINT ["/usr/bin/bwa"]
