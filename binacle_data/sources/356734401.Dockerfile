
##########################
FROM alpine

# FROM alpine:edge
# http://lists.alpinelinux.org/alpine-devel/5463.html
#     [1/38] CC build/release/obj/crypto/initialization_guard.o
# src/crypto/initialization_guard.cc: In constructor 'crypto::initialization_guard_t::initialization_guard_t()':
# src/crypto/initialization_guard.cc:20:32: error: 'OPENSSL_init_ssl' was not declared in this scope
#      OPENSSL_init_ssl(0, nullptr);

MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"
WORKDIR /tmp
ENV RETHINKDB_DIST https://download.rethinkdb.com/dist
ENV RETHINKDB_VERSION rethinkdb-2.3.5

##########################
RUN echo "Rethinkdb for alpine" \
# Dependencies from edge
    && apk --update add \
        --repository http://dl-4.alpinelinux.org/alpine/edge/main \
        libexecinfo-dev \
    # https://www.rethinkdb.com/docs/build/
# Normal dependencies
    && apk --no-cache add \
        --virtual=build_dependencies \
        g++ bash protobuf-dev protobuf-c m4 \
        python-dev perl nodejs \
        icu-dev make wget curl-dev boost-dev \
        jemalloc-dev linux-headers musl-dev \
        findutils coreutils grep tar gzip \
# Rethinkdb package
    # download
    && wget -q $RETHINKDB_DIST/$RETHINKDB_VERSION.tgz \
    && tar xf $RETHINKDB_VERSION.tgz && rm *.tgz \
    && cd $RETHINKDB_VERSION \
    # configuration
    # https://github.com/rethinkdb/rethinkdb/issues/4437#issuecomment-118491138
        # && ./configure --allow-fetch
    && ./configure --allow-fetch LDFLAGS=-lexecinfo \
    # compile and install
    && make -j 4 && make install \
    && cd .. \
    # # remove build?
    # && rm -rf $RETHINKDB_VERSION \
    # # clean packages used to build the database ?
    # && apk del --purge -r build_dependencies \
    && echo "Completed"

ENV SHELL /bin/bash
# ENTRYPOINT [ '/bin/ash' ]
# CMD [ 'rethinkdb', '--bind', 'all' ]
