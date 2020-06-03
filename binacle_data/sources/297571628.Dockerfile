FROM alpine:3.8

MAINTAINER Nikhil Kumar (kumarn1@mskcc.org)

LABEL maintainer="Nikhil Kumar (kumarn1@mskcc.org)" \
      version.image="1.0.0" \
      version.delly="0.7.7" \
      version.htslib="1.6" \
      version.bcftools="1.6" \
      version.samtools="1.6" \
      version.alpine="3.8" \
      source.delly="https://github.com/dellytools/delly/releases/tag/v0.7.7" \
      source.htslib="https://github.com/samtools/htslib/releases/tag/1.6" \
      source.bcftools="https://github.com/samtools/bcftools/releases/tag/1.6" \
      source.samtools="https://github.com/samtools/samtools/releases/tag/1.6"

ENV DELLY_VERSION v0.7.7
ENV HTSLIB_VERSION 1.6
ENV BCFTOOLS_VERSION 1.6
ENV SAMTOOLS_VERSION 1.6

# set environment
ENV BOOST_ROOT /usr
ENV SEQTK_ROOT /opt/htslib

RUN apk add --update --no-cache ncurses \
    && apk add --virtual=deps --update --no-cache ncurses-dev musl-dev git g++ make zlib-dev \
    && apk add build-base asciidoc bzip2-dev xz-dev boost-dev \
    && mkdir /opt \
    && cd /opt \
    # install samtools
    && git clone https://github.com/samtools/htslib.git -b ${HTSLIB_VERSION} \
    && cd /opt/htslib \
    && make \
    && make lib-static \
    && make install \
    # install bcftools
    && cd /opt \
    && git clone https://github.com/samtools/bcftools.git -b ${BCFTOOLS_VERSION} \
    && cd /opt/bcftools \
    && git checkout tags/1.4 \
    && make \
    && make docs \
    && make install \
    # install samtools
    && cd /opt \
    && git clone https://github.com/samtools/samtools.git -b ${SAMTOOLS_VERSION} \
    && cd /opt/samtools \
    && make \
    && make install \
    # install delly
    && cd /opt \
    && git clone https://github.com/tobiasrausch/delly.git -b ${DELLY_VERSION} \
    && cd /opt/delly/ \
    && touch .bcftools .htslib .boost \
    && make all \
    && install -p /opt/delly/src/delly /usr/local/bin/ \
    && install -p /opt/delly/src/cov /usr/local/bin/

#RUN addgroup -S -g 1000 ubuntu
#RUN adduser -S -g -u 1000 ubuntu ubuntu 
#USER ubuntu

# by default /bin/bash is executed
#CMD ["/bin/bash"]
ENTRYPOINT ["/usr/local/bin/delly"]
