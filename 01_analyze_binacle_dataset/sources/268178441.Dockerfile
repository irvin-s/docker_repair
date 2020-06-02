FROM php71-fpm-centos68

MAINTAINER yjc@52fhy.com

# php
ENV PHP_VERSION 7.1.12
ENV PHP_URL="http://cn2.php.net/distributions/php-${PHP_VERSION}.tar.bz2"

# nginx
ENV NGINX_VERSION 1.12.2
ENV PHALCON_VERSION 3.3.1
ENV XHPROF_VERSION 4.1.5

RUN yum -y install git

# php-ext	
RUN pecl install msgpack protobuf yaconf mongodb seaslog

# install phalcon ext
# wget https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz
# git clone --depth=1 "git://github.com/phalcon/cphalcon.git" && cd cphalcon/build && ./install 
COPY cphalcon-${PHALCON_VERSION}.tar.gz /cphalcon-${PHALCON_VERSION}.tar.gz
RUN tar xzf /cphalcon-${PHALCON_VERSION}.tar.gz && cd cphalcon-${PHALCON_VERSION}/build && ./install 

# install xhprof_tideways ext
RUN wget https://github.com/tideways/php-xhprof-extension/archive/v${XHPROF_VERSION}.tar.gz -O php-xhprof-extension-${XHPROF_VERSION}.tar.gz && tar xzf /php-xhprof-extension-${XHPROF_VERSION}.tar.gz && cd php-xhprof-extension-${XHPROF_VERSION} && phpize  && ./configure  && make && make install 

# install gearmand
RUN yum install boost-devel gperf libevent libevent-devel mysql-devel libuuid-devel -y  && \
	wget https://github.com/gearman/gearmand/releases/download/1.1.18/gearmand-1.1.18.tar.gz && \
	tar zxvf gearmand-1.1.18.tar.gz && cd gearmand-1.1.18 &&  \
	./configure  && make && make install

# install gearman ext
# wget https://github.com/gearman/gearmand/releases/download/1.1.18/gearmand-1.1.18.tar.gz -O gearmand-1.1.18.tar.gz && tar xzf gearmand-1.1.18.tar.gz && cd gearmand-1.1.18 && ./configure && make && make install
RUN wget https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.3.tar.gz && tar xzf /gearman-2.0.3.tar.gz && cd  pecl-gearman-gearman-2.0.3 && phpize  && ./configure  && make && make install

# install yac ext
RUN wget http://pecl.php.net/get/yac-2.0.2.tgz && tar xvf yac-2.0.2.tgz && cd yac-2.0.2 && phpize  && ./configure  && make && make install

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
RUN chmod 755 /run.sh

CMD /run.sh && tail -f

EXPOSE 80
EXPOSE 9000

#docker build -t php71-fpm-centos68-phalcon .

