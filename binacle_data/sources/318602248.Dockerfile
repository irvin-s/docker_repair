FROM ubuntu:18.04

RUN apt update
RUN apt upgrade -y
RUN apt install -y git build-essential autoconf re2c bison libxml2-dev nginx libssl-dev runit

WORKDIR /tmp

RUN git clone --depth=1 https://github.com/php/php-src.git

WORKDIR /tmp/php-src

RUN ./buildconf
RUN ./configure --enable-cli --enable-debug --enable-fpm --with-openssl

RUN make -j8
RUN make install

WORKDIR /tmp

RUN git clone https://github.com/martinschroeder/fiber-ext.git

WORKDIR /tmp/fiber-ext

RUN phpize
RUN ./configure
RUN make
RUN make install

RUN echo extension=fiber.so >> /usr/local/lib/php.ini

WORKDIR /app
