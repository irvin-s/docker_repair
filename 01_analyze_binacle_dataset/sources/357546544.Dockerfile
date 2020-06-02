FROM sskorc/symfony2-mongo:latest

ADD . /var/www

RUN chown -R www-data:www-data /var/www
RUN chown -R www-data:www-data /tmp

ADD docker/php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/