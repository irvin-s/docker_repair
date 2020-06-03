FROM ubuntu:16.04

RUN apt-get update && \
  apt-get install -y vim wget git g++ make binutils autoconf automake autotools-dev libtool pkg-config \
  zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
  libjemalloc-dev cython python3-dev python-setuptools && \
  cd /usr/local/src/ && \
  git clone https://github.com/tatsuhiro-t/nghttp2.git && \
  cd ./nghttp2/ && \
  autoreconf -i && automake && autoconf && ./configure && make && make install && \
  cd /usr/local/src/ && \
  wget https://curl.haxx.se/download/curl-7.50.3.tar.gz && \
  tar -zxvf ./curl-7.50.3.tar.gz && \
  cd ./curl-7.50.3 && \
  ./configure --with-nghttp2=/usr/local --with-ssl && make && make install && ldconfig
