FROM php71-fpm-centos68

MAINTAINER yjc@52fhy.com

# php
ENV PHP_VERSION 7.1.12
ENV PHP_URL="http://cn2.php.net/distributions/php-${PHP_VERSION}.tar.bz2"

# RUN yum -y install git

ADD libgearman.so.8 /usr/local/lib/
ADD ext.tar.gz /usr/local/php/lib/php/extensions/no-debug-non-zts-20160303/

# php-ext	
RUN echo "extension=msgpack.so" >> "$PHP_INI_FILE" && \
	echo "extension=protobuf.so" >> "$PHP_INI_FILE" && \
	echo "extension=yac.so" >> "$PHP_INI_FILE" && \
	echo "extension=yaconf.so" >> "$PHP_INI_FILE" && \
	echo "extension=mongodb.so" >> "$PHP_INI_FILE" && \
	echo "extension=seaslog.so" >> "$PHP_INI_FILE" && \
	echo "extension=phalcon.so" >> "$PHP_INI_FILE" && \
	echo "extension=tideways.so" >> "$PHP_INI_FILE" && \
	echo "extension=gearman.so" >> "$PHP_INI_FILE"

ADD ./run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 80
EXPOSE 9000

CMD ["/run.sh"]

#docker build -t php71-fpm-centos68-phalcon-withext .

