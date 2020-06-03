FROM alpine:3.5

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.bcftools="1.3.1" \
      version.alpine="3.5.x" \
      source.bcftools="https://github.com/samtools/bcftools/releases/tag/1.3.1"

ENV BCFTOOLS_VERSION 1.3.1

RUN apk add --update make g++ zlib-dev bzip2-dev xz-dev ncurses-dev \
    && apk add ca-certificates openssl \
    && cd /tmp && wget https://github.com/samtools/bcftools/releases/download/${BCFTOOLS_VERSION}/bcftools-${BCFTOOLS_VERSION}.tar.bz2 \
    && cd /tmp/ && tar xjvf bcftools-${BCFTOOLS_VERSION}.tar.bz2 \
    && cd /tmp/bcftools-${BCFTOOLS_VERSION} \
    && make && make prefix=/usr install \
    && rm -rf /var/cache/apk/* /tmp/*

ENTRYPOINT ["/usr/bin/bcftools"]
CMD ["--help"]
