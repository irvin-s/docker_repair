# NOTE: This is only for Linux
# NOTE: This downloads Qt and builds it statically, so this can take a long time

# To run this, execute in the root of the repository
#    docker build -t loki-gui-image .

# Then execute the script in the root of the repository to copy out the release
# binaries into build/release/bin
#    ./collect_from_docker_container.sh

# This produces a loki-wallet-gui binary with the following dependencies
# linux-vdso.so.1
# libxcb-glx.so.0
# libX11-xcb.so.1
# libxcb.so.1
# libX11.so.6
# libfontconfig.so.1
# libfreetype.so.6
# libdl.so.2
# librt.so.1
# libGL.so.1
# libpthread.so.0
# libm.so.6
# libc.so.6
# /lib64/ld-linux-x86-64.so.2
# libXau.so.6
# libXdmcp.so.6
# libexpat.so.1
# libz.so.1
# libGLX.so.0
# libGLdispatch.so.0
# libbsd.so.0

FROM ubuntu:16.04 as builder

RUN set -ex && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
        ca-certificates \
        cmake \
        g++ \
        make \
        pkg-config \
        graphviz \
        doxygen \
        git \
        curl \
        libtool-bin \
        autoconf \
        automake

ARG NUM_COMPILE_JOBS=1
WORKDIR /usr/local

# NOTE: We install boost and openssl to their default locations because the GUI
# script is less flexible and it sets us up for success in the general case if
# it's in a common location.
ARG BOOST_VERSION=1_66_0
ARG BOOST_VERSION_DOT=1.66.0
ARG BOOST_HASH=5721818253e6a0989583192f96782c4a98eb6204965316df9f5ad75819225ca9
RUN set -ex \
    && curl -L -o  boost_${BOOST_VERSION}.tar.bz2 https://dl.bintray.com/boostorg/release/${BOOST_VERSION_DOT}/source/boost_${BOOST_VERSION}.tar.bz2 \
    && echo "${BOOST_HASH}  boost_${BOOST_VERSION}.tar.bz2" | sha256sum -c \
    && tar -xvf boost_${BOOST_VERSION}.tar.bz2 \
    && cd boost_${BOOST_VERSION} \
    && ./bootstrap.sh --prefix=/usr/ \
    && ./b2 -j${NUM_COMPILE_JOBS} --build-type=minimal link=static runtime-link=static --with-chrono --with-date_time --with-filesystem --with-program_options --with-regex --with-serialization --with-system --with-thread --with-locale threading=multi threadapi=pthread cflags="-fPIC" cxxflags="-fPIC" stage install
ENV BOOST_ROOT /usr/

ARG OPENSSL_VERSION=1.0.2n
ARG OPENSSL_HASH=370babb75f278c39e0c50e8c4e7493bc0f18db6867478341a832a982fd15a8fe
RUN set -ex \
    && curl -O https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz \
    && echo "${OPENSSL_HASH}  openssl-${OPENSSL_VERSION}.tar.gz" | sha256sum -c \
    && tar -xzf openssl-${OPENSSL_VERSION}.tar.gz \
    && cd openssl-${OPENSSL_VERSION} \
    && ./Configure --prefix=/usr/ linux-x86_64 no-shared --static -fPIC \
    && make build_crypto build_ssl -j${NUM_COMPILE_JOBS} \
    && make install
ENV OPENSSL_ROOT_DIR=/usr/

ARG ZMQ_VERSION=v4.2.3
ARG ZMQ_HASH=3226b8ebddd9c6c738ba42986822c26418a49afb
RUN set -ex \
    && git clone https://github.com/zeromq/libzmq.git -b ${ZMQ_VERSION} --depth=1 \
    && cd libzmq \
    && test `git rev-parse HEAD` = ${ZMQ_HASH} || exit 1 \
    && ./autogen.sh \
    && CFLAGS="-fPIC" CXXFLAGS="-fPIC" ./configure --enable-static --disable-shared \
    && make -j${NUM_COMPILE_JOBS} \
    && make install \
    && ldconfig

ARG NCURSES_VERSION=6.1
ARG READLINE_HASH=750d437185286f40a369e1e4f4764eda932b9459b5ec9a731628393dd3d32334
RUN set -ex \
    && curl -O ftp://ftp.invisible-island.net/ncurses/ncurses-6.1.tar.gz \
    && tar -xzf ncurses-${NCURSES_VERSION}.tar.gz \
    && cd ncurses-${NCURSES_VERSION} \
    && CFLAGS="-fPIC" CXXFLAGS="-P -fPIC" ./configure --prefix=/usr/ --enable-termcap --with-termlib \
    && make -j${NUM_COMPILE_JOBS} \
    && make install

ARG CPPZMQ_HASH=6aa3ab686e916cb0e62df7fa7d12e0b13ae9fae6
RUN set -ex \
    && git clone https://github.com/zeromq/cppzmq.git -b ${ZMQ_VERSION} --depth=1 \
    && cd cppzmq \
    && test `git rev-parse HEAD` = ${CPPZMQ_HASH} || exit 1 \
    && cp *.hpp /usr/local/include

ARG READLINE_VERSION=7.0
ARG READLINE_HASH=750d437185286f40a369e1e4f4764eda932b9459b5ec9a731628393dd3d32334
RUN set -ex \
    && curl -O https://ftp.gnu.org/gnu/readline/readline-${READLINE_VERSION}.tar.gz \
    && echo "${READLINE_HASH}  readline-${READLINE_VERSION}.tar.gz" | sha256sum -c \
    && tar -xzf readline-${READLINE_VERSION}.tar.gz \
    && cd readline-${READLINE_VERSION} \
    && CFLAGS="-fPIC" CXXFLAGS="-fPIC" ./configure --prefix=/usr/ \
    && make -j${NUM_COMPILE_JOBS} \
    && make install

ARG SODIUM_VERSION=1.0.16
ARG SODIUM_HASH=675149b9b8b66ff44152553fb3ebf9858128363d
RUN set -ex \
    && git clone https://github.com/jedisct1/libsodium.git -b ${SODIUM_VERSION} --depth=1 \
    && cd libsodium \
    && test `git rev-parse HEAD` = ${SODIUM_HASH} || exit 1 \
    && ./autogen.sh \
    && CFLAGS="-fPIC" CXXFLAGS="-fPIC" ./configure --prefix=/usr/ \
    && make -j${NUM_COMPILE_JOBS} \
    && make install

# Setup gui dependencies
# QT External Dependencies
RUN set -ex && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
        ^libxcb.* \
        libfontconfig1-dev \
        libfreetype6-dev \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        libx11-dev \
        libx11-xcb-dev \
        libxfixes-dev \
        libxkbcommon-dev \
        libxrender-dev \
        p7zip-full \
        python

# Setup QT in separate steps because its absurdly slow, so we can cache as much work as possible
ARG QT_VERSION=5.7.1
RUN set -ex \
    && curl -O -L https://download.qt.io/archive/qt/5.7/5.7.1/single/qt-everywhere-opensource-src-${QT_VERSION}.7z \
    && 7z x qt-everywhere-opensource-src-${QT_VERSION}.7z

RUN set -ex \
    && cd qt-everywhere-opensource-src-${QT_VERSION} \
    && ./configure -prefix /usr/lib/x86_64-linux-gnu/qt5 -static -nomake tests -nomake examples -opensource -confirm-license -opengl desktop -qt-zlib -qt-libjpeg -qt-libpng -qt-xcb -qt-xkbcommon-x11 -qt-freetype -qt-pcre -qt-harfbuzz -fontconfig

RUN set -ex \
    && cd qt-everywhere-opensource-src-${QT_VERSION} \
    && make -j${NUM_COMPILE_JOBS} \
    && make install

ARG QT_DIR=/usr/lib/x86_64-linux-gnu/qt5
ENV PATH=/usr/lib/x86_64-linux-gnu/qt5/bin:${PATH}
RUN set -ex \
    && cd qt-everywhere-opensource-src-${QT_VERSION}/qtdeclarative \
    && qmake && make -j${NUM_COMPILE_JOBS} \
    && make install

# I don't know why this is necessary for the GUI and not the daemon, but it works
ARG ZMQ_INCLUDE_PATH=/usr/local/include/
ARG ZMQ_LIBRARY=/usr/local/libzmq/src/.libs/libzmq.a

ARG LIBUNWIND_VERSION=1.2.1
ARG LIBUNWIND_HASH=3f3ecb90e28cbe53fba7a4a27ccce7aad188d3210bb1964a923a731a27a75acb
RUN set -ex \
    && curl -O -L http://download.savannah.nongnu.org/releases/libunwind/libunwind-${LIBUNWIND_VERSION}.tar.gz \
    && tar xvf libunwind-${LIBUNWIND_VERSION}.tar.gz \
    && echo "${LIBUNWIND_HASH}  libunwind-${LIBUNWIND_VERSION}.tar.gz" | sha256sum -c \
    && cd libunwind-${LIBUNWIND_VERSION} \
    && CFLAGS="-fPIC" CXXFLAGS="-fPIC" ./configure --enable-shared=no \
    && make install

RUN set -ex && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
      bzip2 \
      xsltproc \
      gperf

# Udev
ARG UDEV_VERSION=v3.2.6
ARG UDEV_HASH=0c35b136c08d64064efa55087c54364608e65ed6
RUN set -ex \
    && git clone https://github.com/gentoo/eudev -b ${UDEV_VERSION} --depth=1 \
    && cd eudev \
    && test `git rev-parse HEAD` = ${UDEV_HASH} || exit 1 \
    && ./autogen.sh \
    && CFLAGS="-fPIC" CXXFLAGS="-fPIC" ./configure --disable-gudev --disable-introspection --disable-hwdb --disable-manpages --disable-shared \
    && make \
    && make install

# Libusb
ARG USB_VERSION=v1.0.22
ARG USB_HASH=0034b2afdcdb1614e78edaa2a9e22d5936aeae5d
RUN set -ex \
    && git clone https://github.com/libusb/libusb.git -b ${USB_VERSION} --depth=1 \
    && cd libusb \
    && test `git rev-parse HEAD` = ${USB_HASH} || exit 1 \
    && ./autogen.sh \
    && CFLAGS="-fPIC" CXXFLAGS="-fPIC" ./configure --prefix=/usr/ --enable-static=yes --enable-shared=no \
    && make \
    && make install

# Hidapi
ARG HIDAPI_VERSION=hidapi-0.8.0-rc1
ARG HIDAPI_HASH=40cf516139b5b61e30d9403a48db23d8f915f52c
RUN set -ex \
    && git clone https://github.com/signal11/hidapi -b ${HIDAPI_VERSION} --depth=1 \
    && cd hidapi \
    && test `git rev-parse HEAD` = ${HIDAPI_HASH} || exit 1 \
    && ./bootstrap \
    && CFLAGS="-fPIC" CXXFLAGS="-fPIC" ./configure --enable-static --disable-shared \
    && make \
    && make install

ADD . /src
WORKDIR /src

ENV USE_SINGLE_BUILDDIR=1
RUN set -ex \
    && rm -rf build \
    && ./build.sh release-static \
    && cd build \
    && make deploy
