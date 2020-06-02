FROM ubuntu:16.04

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.bwa="0.7.5a" \
      version.ubuntu="16.04" \
      source.bwa="https://github.com/lh3/bwa/releases/tag/0.7.5a"

ENV BWA_VERSION 0.7.5a

RUN apt-get -y update \
      # install build tools and dependencies
            && apt-get -y install build-essential zlib1g-dev wget unzip \
      # download and unzip bwa
            && cd /tmp && wget https://github.com/lh3/bwa/archive/${BWA_VERSION}.zip \
            && unzip ${BWA_VERSION}.zip \
      # build
            && cd /tmp/bwa-${BWA_VERSION} \
            && make \
      # move binaries to /usr/bin
            && mv /tmp/bwa-${BWA_VERSION}/bwa /usr/bin \
      # clean up
            && rm -rf /tmp/*

ENTRYPOINT ["/usr/bin/bwa"]
