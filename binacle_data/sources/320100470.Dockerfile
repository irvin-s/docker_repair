FROM alpine:3.3

ENV MESOS_VERSION 1.0.1
RUN apk --no-cache add curl python
RUN apk --update add --virtual build-dependencies \
    alpine-sdk \
    libtool \
    make \
    patch \
    g++ \
    subversion-dev \
    zlib-dev \
    curl-dev \
    apr-dev \
    linux-headers \
    python-dev \
    fts-dev \
    cyrus-sasl-dev \
    cyrus-sasl-crammd5 \
 && mkdir -p /tmp/target \
 && curl -sL http://www.apache.org/dist/mesos/$MESOS_VERSION/mesos-$MESOS_VERSION.tar.gz \
    | gunzip \
    | tar x -C /tmp/ \
 && cd /tmp/mesos-$MESOS_VERSION \
 && ./configure --disable-java --prefix /tmp/target \
 && make install -j5 \
 && rm -rf /var/cache/apk/* \
 && apk del build-dependencies

