FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get install -y \
      build-essential \
      libfcgi-dev \
      libssl-dev \
      unixodbc-dev \
      libmysqlclient-dev \
      libopencv-dev \
      libmagickwand-dev \
      lighttpd \
      wget \
      unzip \
      curl \
      automake

RUN mkdir -p /build/poco
RUN wget -O /build/poco/poco.tar.gz http://pocoproject.org/releases/poco-1.6.0/poco-1.6.0-all.tar.gz
RUN cd /build/poco && \
    tar xvf poco.tar.gz && \
    cd poco-* && \
    ./configure && \
    make && \
    make install

RUN mkdir -p /build/dhash
RUN wget -O /build/dhash/dhash.zip https://github.com/moravianlibrary/dhash/archive/1.0.0.zip
RUN cd /build/dhash && \
    unzip dhash.zip && \
    cd dhash-* && \
    autoreconf -i && \
    ./configure && \
    make && \
    make install

RUN mkdir -p /build/blockhash
RUN wget -O /build/blockhash/blockhash.zip https://github.com/moravianlibrary/blockhash/archive/1.0.0.zip
RUN cd /build/blockhash && \
    unzip blockhash.zip && \
    cd blockhash-* && \
    make all && \
    cp blockhash.h /usr/local/include && \
    cp dist/Release/GNU-Linux-x86/libblockhash.so /usr/local/lib


RUN ldconfig /usr/local/lib

RUN mkdir /shared
COPY readers_count /shared/readers_count
COPY can_read /shared/can_read
RUN touch /shared/blockhash
RUN touch /shared/dhash
RUN touch /shared/gaussdhash
RUN touch /shared/gauss2dhash
RUN touch /shared/gaussblockhash
RUN chmod -R a+w /shared

COPY lighttpd-imagesearch.conf /etc/lighttpd/conf-available/30-imagesearch.conf
RUN lighttpd-enable-mod fastcgi
RUN lighttpd-enable-mod imagesearch

COPY web /var/www/html

COPY fcgi /build/fcgi
RUN cd /build/fcgi && make -e CONF=Release

EXPOSE 80

COPY init.sh /init.sh
ENTRYPOINT ["/init.sh"]
