FROM php:7.1.4-alpine

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

RUN apk --no-cache --update add \
        pcre-dev \
        apache2 \
        curl-dev \
        zlib-dev \
        libxml2-dev \
        libmcrypt-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        icu-dev \
    && docker-php-ext-install \
        pdo \
        opcache \
        phar \
        dom \
        exif \
        gd \
        curl \
        xml \
        zip \
        mbstring \
        session \
        ctype \
        mysqli \
        pdo_mysql \
        json \
        mcrypt \
        intl

RUN apk --update add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata

ADD apache2.conf /etc/apache2/apache2.conf
ADD 000-default.conf /etc/apache2/conf.d/default.conf
ADD php.ini /usr/local/etc/php/php.ini

# locale
#RUN apk --no-cache --update add locales
#RUN locale-gen ja_JP.UTF-8  
ENV LANG ja_JP.UTF-8  
ENV LANGUAGE ja_JP:en  
ENV LC_ALL ja_JP.UTF-8  
#RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

RUN mkdir -p /run/apache2
RUN mkdir /var/www/html/
VOLUME  /var/www/html/
WORKDIR /var/www/html
EXPOSE 80
CMD httpd -D FOREGROUND
