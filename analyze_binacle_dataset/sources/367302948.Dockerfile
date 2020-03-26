FROM ubuntu:15.10
MAINTAINER Davey Shafik <dshafik@akamai.com>

RUN apt-get update
RUN apt-get install --yes build-essential bison wget git curl g++ make binutils autoconf automake autotools-dev libtool pkg-config \
  zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
  libjemalloc-dev vim gdb libnghttp2-dev 
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 5.0.0
RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --verify SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc
RUN apt-get remove --yes curl

RUN apt-get build-dep --yes curl

ENV CFLAGS -O0 -ggdb3
ENV LD_LIBRARY_PATH /usr/local/lib

RUN git clone https://github.com/tatsuhiro-t/nghttp2.git
WORKDIR nghttp2
RUN git checkout v1.4.0
RUN autoreconf -i && automake && autoconf && ./configure && make && make install
WORKDIR ..
RUN git clone https://github.com/bagder/curl.git
WORKDIR curl
RUN ./buildconf && ./configure --with-nghttp2 --with-ssl --enable-debug
RUN make && make install
WORKDIR ..
RUN git clone https://github.com/dshafik/php-src.git
WORKDIR php-src
RUN git checkout curl-http2-push && ./buildconf && ./configure --disable-all --enable-debug --with-curl && make
WORKDIR ..
RUN git clone https://github.com/dshafik/php-http2-push-example.git
WORKDIR php-http2-push-example/node-server
RUN npm install
WORKDIR ../../
RUN git clone https://github.com/bagder/curl-http2-dev.git
COPY ./run.sh /run.sh
RUN chmod +x ./run.sh
CMD echo "Running" && ./run.sh 
