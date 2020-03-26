FROM alpine:3.8

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.pindel="0.2.5b8" \
      version.htslib="1.4" \
      version.alpine="3.8" \
      source.pindel="https://github.com/genome/pindel/releases/tag/0.2.5b8" \
      source.htslib="https://github.com/samtools/htslib/releases/tag/1.4"

ENV PINDEL_VERSION 0.2.5b8
ENV HTSLIB_VERSION 1.4

# required for compiling htslib : zlib-dev bzip2-dev xz-dev ncurses-dev
RUN apk add --update make g++ zlib-dev bzip2-dev xz-dev ncurses-dev curl-dev \
      && apk add ca-certificates openssl \
      && cd /tmp && wget https://github.com/samtools/htslib/releases/download/${HTSLIB_VERSION}/htslib-${HTSLIB_VERSION}.tar.bz2 \
      && tar xvjf htslib-${HTSLIB_VERSION}.tar.bz2 \
      && cd /tmp/htslib-${HTSLIB_VERSION} \
      && ./configure \
      && make && make install \
      && cd /tmp && wget https://github.com/genome/pindel/archive/v${PINDEL_VERSION}.zip \
      && unzip v${PINDEL_VERSION}.zip \
      && cd /tmp/pindel-${PINDEL_VERSION} \
      && sed -i[.bak] '1i#include <cmath>' ./src/bddata.cpp \
      && ./INSTALL /tmp/htslib-${HTSLIB_VERSION} \
      && mv /tmp/pindel-${PINDEL_VERSION}/pindel /usr/bin \
      && mv /tmp/pindel-${PINDEL_VERSION}/pindel2vcf /usr/bin \
      && mv /tmp/pindel-${PINDEL_VERSION}/sam2pindel /usr/bin \
      && mv /tmp/pindel-${PINDEL_VERSION}/pindel2vcf4tcga /usr/bin \
      && rm -rf /var/cache/apk/* /tmp/*

ENTRYPOINT ["/usr/bin/pindel"]
CMD ["-h"]
