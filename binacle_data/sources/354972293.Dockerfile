# Pull base image.
FROM ibbd/php-fpm

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

WORKDIR /var/www

RUN pecl install --force xhprof
RUN docker-php-ext-install xhprof 
#RUN docker-php-ext-configure  --enable-phpdbg
#RUN docker-php-ext-enable  phpdbg.so

