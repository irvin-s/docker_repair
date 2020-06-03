FROM php56-fpm-centos68

MAINTAINER yjc@52fhy.com

# RUN yum -y install git

ADD libgearman.tar.gz /usr/local/lib/
RUN ln -s /usr/local/lib/libgearman.so.8.0.0 /usr/local/lib/libgearman.so && \
	ln -s /usr/local/lib/libgearman.so.8.0.0 /usr/local/lib/libgearman.so.8
ADD ext.tar.gz /usr/local/php/lib/php/extensions/no-debug-non-zts-20131226

# php-ext	
RUN echo "extension=msgpack.so" >> "$PHP_INI_FILE" && \
	echo "extension=protobuf.so" >> "$PHP_INI_FILE" && \
	echo "extension=yac.so" >> "$PHP_INI_FILE" && \
	echo "extension=mongodb.so" >> "$PHP_INI_FILE" && \
	echo "extension=seaslog.so" >> "$PHP_INI_FILE" && \
	echo "extension=phalcon.so" >> "$PHP_INI_FILE" && \
	echo "extension=tideways.so" >> "$PHP_INI_FILE" && \
	echo "extension=gearman.so" >> "$PHP_INI_FILE"

#RUN yum -y install libevent-devel && echo "extension=libevent.so" >> "$PHP_INI_FILE"

ADD ./run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 80
EXPOSE 9000

CMD ["/run.sh"]

#docker build -t php56-fpm-centos68-withext .

