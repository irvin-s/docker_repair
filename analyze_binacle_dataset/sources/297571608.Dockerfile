FROM alpine:3.8

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.bcftools="1.5" \
      version.alpine="3.8" \
      source.bcftools="https://github.com/samtools/bcftools/releases/tag/1.5"

ENV BCFTOOLS_VERSION 1.5

RUN apk add --update \
    # install build tools and dependencies
        && apk add build-base zlib-dev bzip2-dev xz-dev ncurses-dev \
    # install openssl and certificates for wget
        && apk add ca-certificates openssl \
    # download and unzip bcftools
        && cd /tmp && wget https://github.com/samtools/bcftools/releases/download/${BCFTOOLS_VERSION}/bcftools-${BCFTOOLS_VERSION}.tar.bz2 \
        && cd /tmp/ && tar xjvf bcftools-${BCFTOOLS_VERSION}.tar.bz2 \
    # build
        && cd /tmp/bcftools-${BCFTOOLS_VERSION} \
        && make && make prefix=/usr install \
    # clean up
        && rm -rf /var/cache/apk/* /tmp/*

ENTRYPOINT ["/usr/bin/bcftools"]
CMD ["--help"]
