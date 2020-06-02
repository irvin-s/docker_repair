FROM ubuntu:latest
RUN apt-get update && apt-get install -y \
  git-core \
  subversion \
  wget \
  cmake \
  autoconf \
  g++ \
  gcc-multilib \
  libpng-dev

RUN mkdir /ddro && mkdir /ddro/smlnj 
ENV DDRO_ROOT=/ddro

WORKDIR /ddro/smlnj
RUN wget http://smlnj.cs.uchicago.edu/dist/working/110.79/config.tgz
RUN tar xzf config.tgz
RUN config/install.sh

ENV SMLNJ_CMD=$DDRO_ROOT/smlnj/bin/sml

WORKDIR /ddro
RUN svn co https://svn.code.sf.net/p/teem/code/teem/trunk teem-src
RUN mkdir teem-ddro && mkdir teem-ddro-build && mkdir teem-util && mkdir teem-util-build
WORKDIR teem-ddro-build
RUN cmake \
  -D BUILD_EXPERIMENTAL_APPS=OFF -D BUILD_EXPERIMENTAL_LIBS=OFF \
  -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=Release \
  -D Teem_BZIP2=OFF -D Teem_FFTW3=OFF -D Teem_LEVMAR=OFF -D Teem_PTHREAD=OFF \
  -D Teem_PNG=OFF -D Teem_ZLIB=OFF \
  -D CMAKE_INSTALL_PREFIX:PATH=/ddro/teem-ddro \
  ../teem-src
RUN make install
WORKDIR /ddro/teem-util-build
RUN cmake \
  -D BUILD_EXPERIMENTAL_APPS=OFF -D BUILD_EXPERIMENTAL_LIBS=OFF \
  -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=Release \
  -D Teem_BZIP2=OFF -D Teem_FFTW3=OFF -D Teem_LEVMAR=OFF -D Teem_PTHREAD=OFF \
  -D Teem_PNG=ON -D Teem_ZLIB=ON \
  -D CMAKE_INSTALL_PREFIX:PATH=/ddro/teem-util \
  ../teem-src
RUN make install

WORKDIR /ddro
RUN svn co --username anonsvn --password=anonsvn --non-interactive --trust-server-cert https://smlnj-gforge.cs.uchicago.edu/svn/diderot/branches/vis12
WORKDIR /ddro/vis12
RUN autoheader -Iconfig && autoconf -Iconfig
RUN ./configure --with-teem=/ddro/teem-ddro
RUN make local-install

WORKDIR /ddro
RUN git clone https://github.com/Diderot-Language/examples.git
WORKDIR /ddro/examples/hello
RUN ../../vis12/bin/diderotc --exec hello.diderot
