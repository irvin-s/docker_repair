FROM debian:stable-slim

# Install required packages
RUN apt-get update && apt-get install -y \
    # runtime libraries
    libgnutls30 \
    libssl1.0.2 \
    libjansson4 \
    libmicrohttpd12 \
    libcurl3-gnutls \
    uuid \
    libldap-2.4-2 \
    libmariadbclient18 \
    libsqlite3-0 \
    libconfig9 \
    # dev libraries and tools to build libjwt
    autoconf \
    libtool \
    make \
    libgnutls28-dev \
    libssl-dev \
    wget \
    libjansson-dev

ARG GLEWLWYD_VERSION
ARG LIBJWT_VERSION=1.9.0

# libtool and autoconf may be required, install them with 'sudo apt install libtool autoconf'
RUN cd /opt && \
    wget https://github.com/benmcollins/libjwt/archive/v${LIBJWT_VERSION}.tar.gz && \
    tar -zxvf v${LIBJWT_VERSION}.tar.gz && \
    rm v${LIBJWT_VERSION}.tar.gz && \
    cd libjwt-${LIBJWT_VERSION}/ && \
    autoreconf -i && \
    ./configure --without-openssl && \
    make && \
    make install && \
    cd .. && \
    rm -rf libjwt-${LIBJWT_VERSION}/ && \
    # Download and install Glewlwyd package
    cd /opt && \
    wget https://github.com/babelouest/glewlwyd/releases/download/v${GLEWLWYD_VERSION}/glewlwyd-full_${GLEWLWYD_VERSION}_Debian_stretch_x86_64.tar.gz && \
    tar -xf glewlwyd-full_${GLEWLWYD_VERSION}_Debian_stretch_x86_64.tar.gz && \
    rm glewlwyd-full_${GLEWLWYD_VERSION}_Debian_stretch_x86_64.tar.gz && \
    dpkg -i liborcania_*.deb && \
    dpkg -i libyder_*.deb && \
    dpkg -i libulfius_*.deb && \
    dpkg -i libhoel_*.deb && \
    dpkg -i glewlwyd_*.deb && \
    rm -rf * && \
    ldconfig && \
    # Clean dev packages
    apt-get update && apt-get purge -y \
    autoconf \
    libtool \
    make \
    libgnutls28-dev \
    libssl-dev \
    wget \
    libjansson-dev && \
    apt-get autoremove --purge -y && \
		apt-get clean && rm -rf /var/lib/apt/lists/* 

COPY ["entrypoint.sh", "/"]

EXPOSE 4593

CMD ["/entrypoint.sh"]
