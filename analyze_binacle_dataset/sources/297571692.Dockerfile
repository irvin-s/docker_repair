FROM alpine:3.5

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.pindel="0.2.5a7" \
      version.samtools="0.1.19" \
      version.alpine="3.5.x" \
      source.pindel="https://github.com/genome/pindel/releases/tag/0.2.5a7" \
      source.samtools="https://github.com/samtools/samtools/releases/tag/0.1.19"

ENV PINDEL_VERSION 0.2.5a7
ENV SAMTOOLS_VERSION 0.1.19

# required for compiling samtools : make g++ zlib-dev bzip2-dev xz-dev ncurses-dev
RUN apk add --update make g++ zlib-dev bzip2-dev xz-dev ncurses-dev \
      && apk add ca-certificates openssl \
      && cd /tmp && wget https://github.com/samtools/samtools/archive/${SAMTOOLS_VERSION}.zip \
      && unzip ${SAMTOOLS_VERSION}.zip \
      && cd /tmp/samtools-${SAMTOOLS_VERSION} \
      && make \
      && cd /tmp && wget https://github.com/genome/pindel/archive/v${PINDEL_VERSION}.zip \
      && unzip v${PINDEL_VERSION}.zip \
      && cd /tmp/pindel-${PINDEL_VERSION} \
      && sed -i[.bak] '1i#include <cmath>' ./src/bddata.cpp \
      && ./INSTALL /tmp/samtools-${SAMTOOLS_VERSION} \
      && mv /tmp/pindel-${PINDEL_VERSION}/pindel /usr/bin \
      && mv /tmp/pindel-${PINDEL_VERSION}/pindel2vcf /usr/bin \
      && mv /tmp/pindel-${PINDEL_VERSION}/sam2pindel /usr/bin \
      && rm -rf /var/cache/apk/* /tmp/*

ENTRYPOINT ["/usr/bin/pindel"]
CMD ["-h"]
