FROM alpine:3.7

# Install required packages
RUN apk add --no-cache \
    # development packages to be removed after build
    tar \
    autoconf \
    automake \
    libcurl \
    jansson-dev \
    make \
    gcc \
    g++ \
    util-linux-dev \
    # runtime libraries
    libuuid \
    libconfig \
    gnutls-dev \
    gnutls \
    jansson \
    libgcrypt \
    libmicrohttpd \
    sqlite-libs \
    mariadb-client-libs \
    libtool \
    libldap \
    wget \
    cmake \
    bash

ARG GLEWLWYD_VERSION
ARG LIBJWT_VERSION=1.9.0

# libtool and autoconf may be required, install them with 'sudo apt-get install libtool autoconf'
RUN mkdir /opt && \
    cd /opt && \
    wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz && \
    tar -zxvf v${LIBJWT_VERSION}.tar.gz && \
    rm v${LIBJWT_VERSION}.tar.gz && \
    cd libjwt-${LIBJWT_VERSION}/ && \
    autoreconf -i && \
    ./configure --without-openssl && \
    make && \
    make install && \
# Download and install Glewlwyd package
    cd /opt && \
    wget https://github.com/babelouest/glewlwyd/releases/download/v${GLEWLWYD_VERSION}/glewlwyd-full_${GLEWLWYD_VERSION}_Alpine_3.7_x86_64.tar.gz && \
    tar -xf glewlwyd-full_${GLEWLWYD_VERSION}_Alpine_3.7_x86_64.tar.gz && \
    rm glewlwyd-full_${GLEWLWYD_VERSION}_Alpine_3.7_x86_64.tar.gz && \
    tar xf liborcania_*.tar.gz && \
    mv liborcania_*/lib64/* /usr/lib && \
    tar xf libyder_*.tar.gz && \
    mv libyder_*/lib64/* /usr/lib && \
    tar xf libulfius_*.tar.gz && \
    mv libulfius_*/lib64/* /usr/lib && \
    tar xf libhoel_*.tar.gz && \
    mv libhoel_*/lib64/* /usr/lib && \
    tar xf glewlwyd_*.tar.gz && \
    mv glewlwyd_*/bin/glewlwyd /usr/bin && \
    mkdir -p /usr/share/glewlwyd/ && \
    mv glewlwyd_*/share/glewlwyd/webapp/ /usr/share/glewlwyd/ && \
    rm -rf * && \
    apk del \
    tar \
    autoconf \
    automake \
    libcurl \
    jansson-dev \
    make \
    gcc \
    g++ \
    util-linux-dev

COPY ["entrypoint.sh", "/"]

EXPOSE 4593

CMD ["/entrypoint.sh"]
