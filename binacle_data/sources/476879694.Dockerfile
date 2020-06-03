FROM alpine:3.5

# libxml2 and libjansson are not enabled as they're not needed for building nghttpd & nghttpx
RUN apk add --no-cache openssl libgcc libstdc++ jemalloc libev c-ares zlib \
    && apk add --no-cache --virtual .build-deps openssl-dev gcc g++ git jemalloc-dev libev-dev autoconf automake make libtool c-ares-dev zlib-dev \
    && git clone https://github.com/tatsuhiro-t/nghttp2.git \
    && cd nghttp2/ \
    && autoreconf -i && automake && autoconf && ./configure \
    && make && make install-strip \
    && cd .. && rm -rf nghttp2 \
    && apk del .build-deps

