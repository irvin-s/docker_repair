FROM php:7.2-fpm
RUN apt-get update && \
    apt-get install -y \
        zlib1g-dev \
        libxml2-dev \
        curl \
        libcurl3 \
        libcurl4-openssl-dev \
        libpng-dev \
        libfreetype6-dev \
	libjpeg62-turbo-dev \
        libssl-dev \
        zip \
        cron 
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install zip
# RUN docker-php-ext-install xml
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install tokenizer
RUN docker-php-ext-install ctype
RUN docker-php-ext-install json
RUN docker-php-ext-install bcmath
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd
ADD config/php-fpm.conf /usr/local/etc/php-fpm.conf
ADD config/php.ini /usr/local/etc/php/php.ini
WORKDIR /var/www
CMD sh bootstrap.sh
EXPOSE 9000