FROM alpine:3.4

ENV MESOS_VERSION=1.0.1 

RUN apk --no-cache add python \
    subversion-libs \
    libstdc++ \
    fts \
    libcurl \
    py-pip \
 && apk --no-cache add --virtual .build-deps \
    curl \
    build-base \
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
 && curl -sL http://www.apache.org/dist/mesos/$MESOS_VERSION/mesos-$MESOS_VERSION.tar.gz \
    | gunzip \
    | tar x -C /tmp/ \
 && mkdir -p /tmp/mesos-$MESOS_VERSION/build && cd /tmp/mesos-$MESOS_VERSION/build \
 && ../configure --enable-optimized \
                 --disable-java \
                 --enable-silent-rules \
 && make -j7 \
 && pip --no-cache-dir install -U pip setuptools wheel \
 && pip --no-cache-dir install --use-wheel \
                               --find-links=/tmp/mesos-$MESOS_VERSION/build/src/python/dist \
                               'protobuf<3' mesos \
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/* \
 && apk del .build-deps

# /usr/lib/python2.7/site-packages/mesos/scheduler # ldd _scheduler.so
#         ldd (0x7fc0221f4000)
#         libpython2.7.so.1.0 => /usr/lib/libpython2.7.so.1.0 (0x7fc01b73c000)
#         libz.so.1 => /lib/libz.so.1 (0x7fc01b526000)
#         libsvn_delta-1.so.0 => /usr/lib/libsvn_delta-1.so.0 (0x7fc01b315000)
#         libsvn_subr-1.so.0 => /usr/lib/libsvn_subr-1.so.0 (0x7fc01affe000)
#         libsasl2.so.3 => /usr/lib/libsasl2.so.3 (0x7fc01ade5000)
#         libcurl.so.4 => /usr/lib/libcurl.so.4 (0x7fc01ab87000)
#         libapr-1.so.0 => /usr/lib/libapr-1.so.0 (0x7fc01a95b000)
#         libfts.so.0 => /usr/lib/libfts.so.0 (0x7fc01a757000)
#         libstdc++.so.6 => /usr/lib/libstdc++.so.6 (0x7fc01a407000)
#         libgcc_s.so.1 => /usr/lib/libgcc_s.so.1 (0x7fc01a1f4000)
#         libc.musl-x86_64.so.1 => ldd (0x7fc0221f4000)
#         libsqlite3.so.0 => /usr/lib/libsqlite3.so.0 (0x7fc019f2d000)
#         libaprutil-1.so.0 => /usr/lib/libaprutil-1.so.0 (0x7fc019d09000)
#         libldap-2.4.so.2 => /usr/lib/libldap-2.4.so.2 (0x7fc019ac9000)
#         liblber-2.4.so.2 => /usr/lib/liblber-2.4.so.2 (0x7fc0198bc000)
#         libdb-5.3.so => /usr/lib/libdb-5.3.so (0x7fc01953b000)
#         libexpat.so.1 => /usr/lib/libexpat.so.1 (0x7fc01931b000)
#         libssh2.so.1 => /usr/lib/libssh2.so.1 (0x7fc0190f2000)
#         libssl.so.1.0.0 => /lib/libssl.so.1.0.0 (0x7fc018e8a000)
#         libcrypto.so.1.0.0 => /lib/libcrypto.so.1.0.0 (0x7fc018a6d000)
#         libuuid.so.1 => /lib/libuuid.so.1 (0x7fc018869000)