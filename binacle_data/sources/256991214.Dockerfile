# Credit goes to ucalgary/python-librdkafka for basis of Docker image
# The following is derived from:
#   https://hub.docker.com/r/ucalgary/python-librdkafka/~/dockerfile/
#
# Author: Scott Haskell
# Title: Principal SE Architect
# Company: Splunk
# Date: 06282017
#
# Build:
#  $ docker build -t sghaskell/kafka-splunk-consumer .
#
# Run:
#  Create local kafka_consumer.yml config file and mount as volume
#	See sample config - https://github.com/sghaskell/kafka-splunk-consumer/blob/master/config/kafka_consumer.yml
#
#  $ docker run -it -v /path/to/local/configdir:/tmp sghaskell/kafka-splunk-consumer kafka_splunk_consumer -c /tmp/kafka_consumer.yml 
#
FROM python:2.7.13-alpine

ARG LIBRDKAFKA_NAME="librdkafka"
ARG LIBRDKAFKA_VER="0.9.4"
ARG KAFKA_SPLUNK_CONSUMER_NAME="kafka-splunk-consumer"
ARG KAFKA_SPLUNK_CONSUMER_VER="0.6-beta"

# Install librdkafka
RUN apk add --no-cache --virtual .fetch-deps \
      ca-certificates \
      openssl \
      tar && \
\
    BUILD_DIR="$(mktemp -d)" && \
\
    wget -O "$BUILD_DIR/$LIBRDKAFKA_NAME.tar.gz" "https://github.com/edenhill/librdkafka/archive/v$LIBRDKAFKA_VER.tar.gz" && \
    mkdir -p $BUILD_DIR/$LIBRDKAFKA_NAME-$LIBRDKAFKA_VER && \
    tar \
      --extract \
      --file "$BUILD_DIR/$LIBRDKAFKA_NAME.tar.gz" \
      --directory "$BUILD_DIR/$LIBRDKAFKA_NAME-$LIBRDKAFKA_VER" \
      --strip-components 1 && \
    wget -O "$BUILD_DIR/$KAFKA_SPLUNK_CONSUMER_NAME.tar.gz" "https://github.com/sghaskell/kafka-splunk-consumer/archive/v$KAFKA_SPLUNK_CONSUMER_VER.tar.gz" && \
    mkdir -p $BUILD_DIR/$KAFKA_SPLUNK_CONSUMER_NAME-$KAFKA_SPLUNK_CONSUMER_VER && \
    tar \
      --extract \
      --file "$BUILD_DIR/$KAFKA_SPLUNK_CONSUMER_NAME.tar.gz" \
      --directory "$BUILD_DIR/$KAFKA_SPLUNK_CONSUMER_NAME-$KAFKA_SPLUNK_CONSUMER_VER" \
      --strip-components 1 && \
\
    apk add --no-cache --virtual .build-deps \
      bash \
      yaml-dev \
      g++ \
      gcc \
      openssl-dev \
      make \
      musl-dev \
      alpine-sdk \
      zlib-dev && \
\
    cd "$BUILD_DIR/$LIBRDKAFKA_NAME-$LIBRDKAFKA_VER" && \
    ./configure \
      --prefix=/usr && \
    make -j "$(getconf _NPROCESSORS_ONLN)" && \
    make install && \
\
    cd "$BUILD_DIR/$KAFKA_SPLUNK_CONSUMER_NAME-$KAFKA_SPLUNK_CONSUMER_VER" && \
    python setup.py install && \
\
    runDeps="$( \
      scanelf --needed --nobanner --recursive /usr/local \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u \
        | xargs -r apk info --installed \
        | sort -u \
      )" && \
    apk add --no-cache --virtual .librdkafka-rundeps \
      $runDeps && \
\
    cd / && \
    apk del .fetch-deps .build-deps && \
    rm -rf $BUILD_DIR
