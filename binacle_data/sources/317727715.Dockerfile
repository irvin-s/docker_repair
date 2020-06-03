FROM alpine:edge
MAINTAINER Derren Desouza <derrend@yahoo.co.uk>
RUN apk --no-cache --update add libstdc++ openssl boost-thread boost-system boost-filesystem boost-program_options alpine-sdk file openssl-dev boost-dev \
    ##
    && cd \
    && wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz \
    && tar -xvf db-4.8.30.NC.tar.gz \
    && cd db-4.8.30.NC \
    && sed -i.old 's/__atomic_compare_exchange/__atomic_compare_exchange_db/' dbinc/atomic.h \
    && cd build_unix \
    && ../dist/configure --disable-shared --enable-cxx --disable-replication --with-pic \
    && make libdb_cxx-4.8.a libdb-4.8.a \
    && make install_lib install_include \
    && export BDB_LIB_PATH=/usr/local/BerkeleyDB.4.8/lib \
    && export BDB_INCLUDE_PATH=/usr/local/BerkeleyDB.4.8/include \
    ##
    && cd \
    && git clone -b master --depth 1 https://github.com/zcoinofficial/zcoin.git \
    && cd zcoin/src \
    && sed -i 's/-l boost_thread/-l boost_thread-mt/g' makefile.unix \
    && make -f makefile.unix USE_UPNP=- RELEASE=1 \
    && strip zcoind \
    && mv zcoind /usr/local/bin \
    ##
    && cd \
    && rm -rf * \
    && apk del alpine-sdk file openssl-dev boost-dev \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/zcoind"]
EXPOSE 18888 8888 18168 8168
