FROM alpine:3.5

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.abra="0.92" \
      version.bwa="0.7.9a" \
      version.alpine="3.5.x" \
      source.abra="https://github.com/mozack/abra/releases/tag/v0.92" \
      source.bwa="https://github.com/lh3/bwa/releases/tag/0.7.9a"

ENV ABRA_VERSION 0.92
ENV BWA_VERSION 0.7.9a

# install abra
# bash : ABRA runs bwa using bash -c (Aligner.java)
# libstdc++ libc6-compat : ABRA requires libc
RUN apk add --update \
      && apk add ca-certificates openssl bash openjdk7-jre \
      && cd /tmp && wget https://github.com/mozack/abra/releases/download/v${ABRA_VERSION}/abra-${ABRA_VERSION}-SNAPSHOT-jar-with-dependencies.jar \
      && mv /tmp/abra-${ABRA_VERSION}-SNAPSHOT-jar-with-dependencies.jar /usr/bin/abra.jar \
      && rm -rf /tmp/*

# install bwa
RUN apk add --update --no-cache ncurses \
      && apk add --virtual=deps --update --no-cache musl-dev zlib-dev make gcc \
      && apk add ca-certificates openssl \
      && cd /tmp && wget https://github.com/lh3/bwa/archive/${BWA_VERSION}.zip \
      && unzip ${BWA_VERSION}.zip \
      && cd /tmp/bwa-${BWA_VERSION} \
      # && sed -i[.bak] "s/u_int32_t/uint32_t/g" *.c \
      # && sed -i[.bak] "s/u_int32_t/uint32_t/g" *.h \
      && make \
      && mv /tmp/bwa-${BWA_VERSION}/bwa /usr/bin \
      && rm -rf /var/cache/apk/* /tmp/* \
      && apk del deps

ENTRYPOINT ["java", "-jar", "/usr/bin/abra.jar"]
CMD ["--help"]
