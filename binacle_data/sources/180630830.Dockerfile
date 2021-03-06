FROM ciceron/ada-bionic:latest

MAINTAINER Stephane Carrez <Stephane.Carrez@gmail.com>

RUN apt-get update \
   && apt-get install -y sqlite3 unzip imagemagick pngcrush libjpeg-progs \
      yui-compressor

RUN mkdir -p /usr/src \
   && cd /usr/src \
   && git clone https://github.com/stcarrez/ada-awa.git ada-awa \
   && cd ada-awa \
   && git submodule init \
   && git submodule update --recursive --remote \
   && ./configure --enable-ahven --disable-shared --prefix=/usr \
   && make -s \
   && make -s install

WORKDIR /usr/src/ada-awa
