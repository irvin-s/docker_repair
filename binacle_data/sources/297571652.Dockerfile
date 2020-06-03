FROM ubuntu:16.04

LABEL maintainer="Nikhil Kumar (kumarn1@mskcc.org)" \
      contributor="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.htstools="0.1.1" \
      version.htslib="1.5" \
      version.ubuntu="16.04" \
      source.htstools="https://github.com/mskcc/htstools/releases/tag/snp_pileup_0.1.1" \
      source.htslib="https://github.com/samtools/htslib/releases/tag/1.5"

ENV HTSTOOLS_VERSION 0.1.1
ENV HTSLIB_VERSION 1.5


RUN   apt-get -y update \
      && apt-get -y install build-essential \
      && apt-get -y install wget \
      && apt-get -y install zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev \
# download, unzip, install htslib
      && cd /tmp \
      && wget https://github.com/samtools/htslib/releases/download/${HTSLIB_VERSION}/htslib-${HTSLIB_VERSION}.tar.bz2 \
      && tar xvjf htslib-${HTSLIB_VERSION}.tar.bz2 \
      && cd /tmp/htslib-${HTSLIB_VERSION} \
      && ./configure \
      && make && make install \
# download, unzip
      && cd /tmp \
      && wget https://github.com/mskcc/htstools/archive/snp_pileup_${HTSTOOLS_VERSION}.tar.gz \
      && tar xvzf snp_pileup_${HTSTOOLS_VERSION}.tar.gz \
      && cd /tmp/htstools-snp_pileup_${HTSTOOLS_VERSION} \
      && cp /tmp/htslib-${HTSLIB_VERSION}/libhts.so /usr/lib \
      && cp /tmp/htslib-${HTSLIB_VERSION}/libhts.so.2 /usr/lib \
# install snp-pileup and ppflag-fixer
      && cd /tmp/htstools-snp_pileup_${HTSTOOLS_VERSION} \
      && g++ -std=c++11 snp-pileup.cpp -lhts -o snp-pileup \
      && g++ -std=c++11 ppflag-fixer.cpp -lhts -o ppflag-fixer \
#move executables into bin
      && cp /tmp/htstools-snp_pileup_${HTSTOOLS_VERSION}/snp-pileup /usr/bin \
      && cp /tmp/htstools-snp_pileup_${HTSTOOLS_VERSION}/ppflag-fixer /usr/bin \
# clean up
      && rm -rf /var/cache/apk/* /tmp/*

ENV PYTHONNOUSERSITE set

ENTRYPOINT ["/bin/bash"]
