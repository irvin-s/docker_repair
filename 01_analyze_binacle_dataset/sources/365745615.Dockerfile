FROM alpine:latest

Maintainer Geshan Manandhar <geshan@gmail.com>

RUN apk --update add wget \ 
	curl \
	git \
	grep \
	gmp-dev \
	libmcrypt-dev \
	freetype-dev \
	libxpm-dev \
	libwebp-dev \
	libjpeg-turbo-dev \
	libjpeg \
	bzip2-dev \
	openssl-dev \
	krb5-dev \
	libxml2-dev \
	build-base \
	tar \
	make \
	autoconf 

RUN apk --update add re2c bison curl-dev

RUN rm /var/cache/apk/*

ADD compile-php.sh /

ADD php.ini /

RUN chmod +x ./compile-php.sh

RUN ./compile-php.sh

RUN mkdir -p /var/www

WORKDIR /var/www

COPY . /var/www

VOLUME /var/www

CMD ["bash"]

ENTRYPOINT ["/bin/sh", "-c"]

