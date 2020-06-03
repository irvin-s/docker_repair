# Dockerfile for building Commercium linux and windows nodes
# You can stack args in the build command, valid arguments for --build-args OS_VER=[14.04-18.10], LOS_TYPE=(not blank), WOS_TYPE=[win32,win64], NODE_GIT_CHECKOUT=(branch, commit, or tag),and SERVER=(not blank)
# We need to declare these values outside and inside the container
ARG OS_VER=18.04
ARG LOS_TYPE
ARG SERVER

##You can choose your OS, most will want the latest as windows only builds on Ubuntu:18
#FROM ubuntu:14.04
#FROM ubuntu:16.04
FROM ubuntu:$OS_VER as build

ARG OS_VER
ARG LOS_TYPE
ARG WOS_TYPE
ARG SERVER
ENV EXPORT=${EXTRACT}

##~~~~~MAIN CONFIGURATION SETTINGS set in docker-compose.yml or with --build-args~~~~~

## you can build one or both os's at one go. For WOS_TYPE choose win32 or win64
#ARG LOS_TYPE=linux
#ARG WOS_TYPE=win64
#ARG WOS_TYPE=win32

## uncomment server for lean binaries without GUI's and with extra tools.
## Windows does not build with server options
#ARG SERVER=1

#Optional you can specify the code branch with --build-arg NODE_GIT_CHECKOUT=v0-1.17 or setting it here
#ARG NODE_GIT_CHECKOUT=v0.1-17
##~~~~~END MOST USE CASE CONFIGURATIONS, EDIT BELOW IF YOU HAVE AN UNUSAL SETUP~~~~~
LABEL maintainer="Commercium Dev Team <info@commercium.net>" \
description="Binary wallet builder for linux or windows commercium nodes. \
With both the Dockerfile and docker-compose.yml files, execute 'docker-compose up' to build. \
Read last few lines of output for the command to extract the built files."

RUN \
  apt-get update \
##Root Dependencies
&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
  automake \
  autotools-dev \
  bsdmainutils \
  build-essential \
  git \
  libevent-dev \
  libssl-dev \
  libtool \
  pkg-config \
  wget \
##Ubuntu boost Dependencies
  libdb-dev \
  libdb++-dev \
  libboost-chrono-dev \
  libboost-filesystem-dev \
  libboost-program-options-dev \
  libboost-system-dev \
  libboost-test-dev \
  libboost-thread-dev \
##If the above boost doesn't work for dev needs, uncomment the next line
#  libboost-all-dev \
##Server or GUI Optionals
&& if [ "$SERVER" ] ; then \
      DEBIAN_FRONTEND=noninteractive apt-get install -y \
      libminiupnpc-dev \
      libzmq3-dev \
  ; fi \
##GUI Front end Dependencies
&& if ! [ "$SERVER" ] ; then \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libjpeg-dev \
    libprotobuf-dev \
    libqrencode-dev \
    libqt5core5a \
    libqt5dbus5 \
    libqt5gui5 \
    protobuf-compiler \
    qt4-linguist-tools \
    qt5-default \
    qttools5-dev \
    qttools5-dev-tools \
  ; fi \
##Windows Build Dependencies
&& if [ "$WOS_TYPE" = "win64" ] ; then \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    g++-mingw-w64-x86-64 \
    mingw-w64-x86-64-dev \
    zip \
&&  update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix \
  ; fi \
&& if [ "$WOS_TYPE" = "win32" ] ; then \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    g++-mingw-w64-i686 \
    mingw-w64-i686-dev \
    zip \
&&  update-alternatives --set i686-w64-mingw32-g++ /usr/bin/i686-w64-mingw32-g++-posix \
  ; fi \
##Ubuntu 14 Build Dependencies
&& if [ $(cut -d " " -f 2 /etc/issue |  cut -d . -f 1) = "14" ] ; then \
    DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common \
&&  DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ubuntu-toolchain-r/test \
&&  apt-get update \
&&  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    gcc-5 \
    g++-5 \
&&  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 --slave /usr/bin/g++ g++ /usr/bin/g++-5 \
&&  update-alternatives --config gcc \
  ; fi \
&& mkdir /build /host

##use more cores to build faster, hopefully without running out of VirtualMemory
ARG MAKEFLAGS="-j$(nproc)"

##We need a specific version of the Berkeley database for wallet functionality
ARG BERKELEY_DB_URL=https://download.oracle.com/berkeley-db
ARG BERKELEY_DB_PACKAGE=db-4.8.30.NC.tar.gz
ARG BERKELEY_DB_PACKAGE_HASH=a14a5486d6b4891d2434039a0ed4c5b7
WORKDIR /build
RUN \
  wget $BERKELEY_DB_URL/$BERKELEY_DB_PACKAGE \
&& echo "$BERKELEY_DB_PACKAGE_HASH $BERKELEY_DB_PACKAGE" | md5sum -c \
&& tar -xzf $BERKELEY_DB_PACKAGE \
&& cd ./db-4.8.30.NC/build_unix/ \
&& ../dist/configure --prefix=/usr/local \
  --disable-shared \
  --enable-cxx \
  --with-pic \
&& make \
&& make check \
&& make install

##Install Node source code and dependencies
ARG NODE_GIT_URL=https://github.com/CommerciumBlockchain/Commercium.git
ARG NODE_GIT_CHECKOUT
##The NODE_GIT_CHECKOUT can be a branch, commit, tag, release, or omitted entierly for the latest code base
#ARG NODE_GIT_CHECKOUT=v0.1-17
#ARG NODE_GIT_CHECKOUT=0.17.0-bitnode

RUN \
  git clone "$NODE_GIT_URL"
WORKDIR /build/Commercium
RUN \
  if [ "$NODE_GIT_CHECKOUT" ] ; then \
    git checkout -b $NODE_GIT_CHECKOUT \
  ; fi

##LibSodium dependency for Ubuntu 14, 18 and windows
RUN \
  if ! [ $(cut -d " " -f 2 /etc/issue |  cut -d . -f 1) = "16" ] ; then \
    git submodule update --init --recursive \
  ; fi

##LibSodium for ubuntu 16
ARG LIBSODIUM_URL=https://download.libsodium.org/libsodium/releases/old
ARG LIBSODIUM_PACKAGE=libsodium-1.0.13.tar.gz
ARG LIBSODIUM_PACKAGE_HASH=f38aac160a4bd05f06f743863e54e499
WORKDIR /build
RUN \
  if [ $(cut -d " " -f 2 /etc/issue |  cut -d . -f 1) = "16" ] ; then \
    wget $LIBSODIUM_URL/$LIBSODIUM_PACKAGE \
&&  echo "$LIBSODIUM_PACKAGE_HASH $LIBSODIUM_PACKAGE" | md5sum -c \
&&  tar xzf $LIBSODIUM_PACKAGE \
&&  mv libsodium-1.0.13/* /build/Commercium/depends/libsodium/ \
  ; fi

WORKDIR /build/Commercium/depends/libsodium
RUN \
 #Autogen not needed when building from tar, but is when building from git submodule
  if ! [ $(cut -d " " -f 2 /etc/issue |  cut -d . -f 1) = "16" ]  ; then \
    ./autogen.sh \
  ; fi \
&& ./configure \
&& make \
&& make check \
&& make install

##Install uniValue for linux servers and hosts
WORKDIR /build/Commercium/src/univalue
RUN \
  if [ "$SERVER" ] ; then \
    ./autogen.sh \
&&  ./configure --prefix=/usr/local \
&&  make \
&&  make check \
&&  make install \
  ; fi

##use fewer cores for building the node to prevent errors
ARG MAKEFLAGS=-j2

#~~~~~ START LINUX ~~~~~-
WORKDIR /build/Commercium
RUN \
  if [ "$LOS_TYPE" ] ; then \
    if [ "$SERVER" ] ; then \
#Build options more useful for servers
      configflags="--disable-wallet --enable-debug --enable-upnp-default --with-miniupnpc --with-system-univalue --with-utils=yes" \
    ; else \
#Build options more useful for end users
      configflags="--disable-shared --with-seeder=no" \
    ; fi \
&&  ./autogen.sh \
&&  ./configure --disable-bench --disable-tests $configflags \
  ; fi

RUN \
  if [ "$LOS_TYPE" ] ; then \
    make \
&&  make check \
  ; fi

#Prepare the Linux files for export
WORKDIR /build
RUN \
  if [ "$LOS_TYPE" ] ; then \
    if [ "$SERVER" ] ; then \
      ostype=$LOS_TYPE \
&&    mkdir /root/.commercium \
    ; else \
      ostype=qt-$LOS_TYPE \
    ; fi \
&&  if ! [ -d export ] ; then mkdir export ; fi \
&&  mkdir commercium-$ostype \
&&  cp Commercium/src/commerciumd commercium-$ostype/ \
&&  if [ -f Commercium/src/commercium-cli ] ; then \
      cp Commercium/src/commercium-cli Commercium/src/commercium-tx commercium-$ostype/ \
    ; fi \
&&  if [ -f Commercium/src/commercium-seeder ] ; then \
      cp Commercium/src/commercium-seeder commercium-$ostype/ \
    ; fi \
&&  if [ -f Commercium/src/qt/commercium-qt ] ; then \
      cp Commercium/src/qt/commercium-qt commercium-$ostype/ \
    ; fi \
&&  tar -czvf export/commercium$NODE_GIT_CHECKOUT-$ostype$OS_VER.tar.gz commercium-$ostype \
  ; fi
#~~~~~ END LINUX ~~~~~

##use fewer cores for building the node to prevent errors
ARG MAKEFLAGS=-j1

#~~~~~ START WIN ~~~~~
WORKDIR /build/Commercium
RUN \
  if [ "$WOS_TYPE" ] ; then \
#Lets only clean if we need to
    if [ "$LOS_TYPE" ] ; then \
      make clean \
    ; fi \
#Windows requires some code changes to this file
&&  sed -e 's/soln.size(), SolutionWidth);/\/\/soln.size(), SolutionWidth);/' -e '/\else$/,/LogPrint/c\ \ \ \ \ \ \ \ }' -e 's/LogPrint/\/\/LogPrint/g' -e 's/crypto\/equihash.h"/crypto\/equihash.h"\n#include "compat\/endian.h"/' -i src/crypto/equihash.cpp \
&&  cd depends \
&&  make if [ "$WOS_TYPE" = "win64" ];then HOST=x86_64-w64-mingw32 ;else HOST=i686-w64-mingw32 ;fi \
  ; fi

RUN \
  if [ "$WOS_TYPE" ] ; then \
    ./autogen.sh \
&&  CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --disable-bench --disable-tests --disable-shared --with-seeder=no --prefix=/ \
  ; fi

RUN \
  if [ "$WOS_TYPE" ] ; then \
  make CXXFLAGS="-W --param ggc-min-expand=1 --param ggc-min-heapsize=32768" \
&&  make check \
  ; fi 
#~~~~~ END WIN ~~~~~
#Prepare Windows files for export
WORKDIR /build
RUN \
  if [ "$WOS_TYPE" ] ; then \
      ostype=qt-$WOS_TYPE \
&&  if ! [ -d export ] ; then mkdir export ; fi \
&&  mkdir commercium-$ostype \
&&  cp Commercium/src/commercium*.exe commercium-$ostype/ \
&&  if [ -f Commercium/src/qt/commercium-qt.exe ] ; then \
      cp Commercium/src/qt/commercium-qt.exe commercium-$ostype/ \
    ; fi \
&&  zip -r export/commercium$NODE_GIT_CHECKOUT-$ostype$OS_VER.zip commercium-$ostype \
  ; fi
#~~~~~ End Windows ~~~~~

RUN \
  if [ "$SERVER" ] && [ "$LOS_TYPE" ] ; then \
    ostype=$LOS_TYPE \
  ; else \
    ostype=qt-$LOS_TYPE \
  ; fi \
&& if [ -f /build/export/commercium$NODE_GIT_CHECKOUT-$ostype$OS_VER.tar.gz ] ; then \
    echo "Now run 'docker cp docker-cmm:/build/export/commercium$NODE_GIT_CHECKOUT-$ostype$OS_VER.tar.gz .' to save the Linux files you compiled." \
  ; fi \
&& if [ "$SERVER" ] && [ "$WOS_TYPE" ] ; then \
    ostype=$WOS_TYPE \
  ; else \
    ostype=qt-$WOS_TYPE \
  ; fi \
&& if [ -f /build/export/commercium$NODE_GIT_CHECKOUT-$ostype$OS_VER.zip ] ; then \
    echo "Now run 'docker cp docker-cmm:/build/export/commercium-$NODE_GIT_CHECKOUT-$ostype$OS_VER.zip .' to save the Windows files you compiled." \
  ; fi 

#If you forgot the export flag you can set it here without needing to rebuild everything
#ENV EXPORT 1
CMD ["bash", "-c", "if [ $EXPORT ];then cp /build/export/* /host/;fi"]

## You can run the linux node in docker if you want. Does not work with windows.
## The blockchain will use an additional 5gigs of drive space.
## To do so uncomment the whole next section and follow the instructions in doc/build-docker.md.

#FROM ubuntu:$OS_VER as run
#ARG OS_VER
#ARG SERVER
#ARG LOS_TYPE
#ARG NODE_GIT_CHECKOUT
#RUN \
#  apt-get update \
###UBUNTU 14 Run Dependencies
#&& if [ "$SERVER" ] && [ "$LOS_TYPE" ] && [ $(cut -d " " -f 2 /etc/issue |  cut -d . -f 1) = "14" ] ; then \
#    DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common \
#&&  DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:ubuntu-toolchain-r/test \
#&&  apt-get update \
#&&  DEBIAN_FRONTEND=noninteractive apt-get install -y \
#    gcc-5 \
#    g++-5 \
#    libboost-chrono1.54 \
#    libboost-filesystem1.54 \
#    libboost-program-options1.54 \
#    libevent-pthreads-2.0-5 \
#    libboost-system1.54.0 \
#    libboost-thread1.54.0 \
#    libevent-2.0-5 \
#    libminiupnpc8 \
#    libssl-dev \
#    libzmq3 \
#&&  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 --slave /usr/bin/g++ g++ /usr/bin/g++-5 \
#&&  update-alternatives --config gcc \
#  ; fi \
###UBUNTU 16 Run Dependencies
#&& if [ "$SERVER" ] && [ "$LOS_TYPE" ] && [ $(cut -d " " -f 2 /etc/issue |  cut -d . -f 1) = "16" ] ; then \
#    DEBIAN_FRONTEND=noninteractive apt-get install -y \
#    libboost-chrono1.58 \
#    libboost-filesystem1.58 \
#    libboost-program-options1.58 \
#    libevent-pthreads-2.0-5 \
#    libboost-system1.58.0 \
#    libboost-thread1.58.0 \
#    libevent-2.0-5 \
#    libminiupnpc10 \
#    libssl-dev \
#    libzmq5 \
#  ; fi \
###Ubuntu 18 Run Dependencies
#&& if [ "$SERVER" ] && [ "$LOS_TYPE" ] && [ $(cut -d " " -f 2 /etc/issue |  cut -d . -f 1) = "18" ] ; then \
#    DEBIAN_FRONTEND=noninteractive apt-get install -y \
#    libboost-chrono1.65.1 \
#    libboost-filesystem1.65.1 \
#    libboost-program-options1.65.1 \
#    libevent-pthreads-2.1-6 \
#    libboost-system1.65.1 \
#    libboost-thread1.65.1 \
#    libevent-2.1-6 \
#    libminiupnpc10 \
#    libssl-dev \
#    libzmq5 \
#  ; fi 
#
#WORKDIR /root
#EXPOSE 8332
#RUN \
#  if [ "$SERVER" ] ; then \
#    mkdir .commercium \
## ~~~~ IT WOULD BE REALLY SMART TO CHANGE THE rpcuser= AND rpcpassword= ~~~~
#&&  printf "server=1\nwhitelist=127.0.0.1\ntxindex=1\naddressindex=1\ntimestampindex=1\nspentindex=1\nzmqpubrawtx=tcp://127.0.0.1:26531\nzmqpubhashblock=tcp://127.0.0.1:26531\nrpcallowip=127.0.0.1\nrpcuser=comcorenode\nrpcpassword=poAVis2e34r\nuacomment=bitcore\nrpcport=8332" > .commercium/commercium.conf \
#  ; fi
#ARG LOS_TYPE
#COPY --from=0 /usr/local/lib/libunivalue.so.0.100.2 /usr/local/lib/libsodium.so.*.0 /usr/local/lib/libunivalue.a /usr/local/lib/libunivalue.la /usr/local/lib/libsodium.la /usr/local/lib/libsodium.a /usr/local/lib/
#COPY --from=0 /build/commercium-$LOS_TYPE-server/commercium* ./
#RUN ldconfig
#CMD ["/bin/bash", "-c", "./commerciumd"]
