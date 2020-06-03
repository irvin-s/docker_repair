FROM debian

MAINTAINER Chu <root@sh3ll.me>

WORKDIR /root/

ADD php-decrypt-eval php-decrypt-eval
ADD php-decrypt-eval.gdb php-decrypt-eval.gdb

RUN apt-get update && apt-get -y install wget vim gcc make gdb \
	&& wget http://cn2.php.net/distributions/php-5.6.31.tar.gz -O /tmp/php-5.6.31.tar.gz \
	&& wget https://zlib.net/zlib-1.2.11.tar.gz -O /tmp/zlib-1.2.11.tar.gz \
	&& tar xzf /tmp/zlib-1.2.11.tar.gz \
	&& (cd zlib-1.2.11 && ./configure && make && make install) && rm -rf zlib-1.2.11 \
	&& tar xzf /tmp/php-5.6.31.tar.gz \
	&& (cd php-5.6.31 && ./configure --disable-libxml --disable-dom --disable-simplexml --disable-xml --disable-xmlreader --disable-xmlwriter --without-pear --with-zlib && make) \
	&& chmod +x php-decrypt-eval && ln -s /root/php-decrypt-eval /usr/bin/php-decrypt-eval \
	&& apt-get clean && apt-get autoclean && apt-get -y --purge autoremove \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
