FROM java:7

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.abra="0.92" \
      version.bwa="0.7.9a" \
      source.abra="https://github.com/mozack/abra/releases/tag/v0.92" \
      source.bwa="https://github.com/lh3/bwa/releases/tag/0.7.9a"

ENV ABRA_VERSION 0.92
ENV BWA_VERSION 0.7.9a

# install abra
RUN apt-get -y update \
      && apt-get -y install build-essential zlib1g-dev \
      && cd /tmp && wget https://github.com/mozack/abra/releases/download/v${ABRA_VERSION}/abra-${ABRA_VERSION}-SNAPSHOT-jar-with-dependencies.jar \
      && mv /tmp/abra-${ABRA_VERSION}-SNAPSHOT-jar-with-dependencies.jar /usr/bin/abra.jar \
      && rm -rf /tmp/*

# install bwa
RUN cd /tmp && wget https://github.com/lh3/bwa/archive/${BWA_VERSION}.zip \
      && unzip ${BWA_VERSION}.zip \
      && cd /tmp/bwa-${BWA_VERSION} \
      && make \
      && mv /tmp/bwa-${BWA_VERSION}/bwa /usr/bin

ENTRYPOINT ["java", "-jar", "/usr/bin/abra.jar"]
CMD ["--help"]
