FROM php:5.6-alpine

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 

RUN mkdir /src \
    && mkdir /composer_tools
ADD composer.json /composer_tools/composer.json

WORKDIR /composer_tools

RUN composer install \
    && ln -s /composer_tools/Vendor/bin/phpcs /usr/local/bin/phpcs \
    && ln -s /composer_tools/Vendor/bin/php-cs-fixer /usr/local/bin/php-cs-fixer \
    && ln -s /composer_tools/Vendor/bin/phpcpd /usr/local/bin/phpcpd \
    && ln -s /composer_tools/Vendor/bin/phpmd /usr/local/bin/phpmd
ADD convert_short_array_syntax.php /usr/local/bin/convert_short_array_syntax
ADD php.ini /usr/local/etc/php/php.ini

WORKDIR /src
