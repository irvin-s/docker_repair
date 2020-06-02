FROM geshan/php-composer-alpine:latest

Maintainer Geshan Manandhar <geshan.com.np>

RUN apk --update add bash php-mysql php-pdo_mysql php-mcrypt php-ctype php-xml python && rm /var/cache/apk/*

RUN composer global require hirak/prestissimo

COPY config/zzz-custom.ini /etc/php/conf.d/

ENTRYPOINT ["/bin/sh", "-c"]

