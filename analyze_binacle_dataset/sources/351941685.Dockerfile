FROM wordpress:php5.6

RUN apt-get update && apt-get install -y git wget subversion cvs bzr mysql-client libxml2-dev

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && chmod +x /usr/local/bin/wp

RUN wget https://phar.phpunit.de/phpunit-5.7.phar -O /usr/local/bin/phpunit && chmod +x /usr/local/bin/phpunit

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pecl install xdebug-2.5.5

RUN sed -i "s/WP_DEBUG', false/WP_DEBUG', true/" /usr/src/wordpress/wp-config-sample.php

RUN docker-php-ext-install opcache

RUN docker-php-ext-install soap

COPY php/php.ini /usr/local/etc/php/php.ini

COPY php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

RUN echo "zend_extension = /usr/local/lib/php/extensions/$(ls /usr/local/lib/php/extensions | tail -n 1)/xdebug.so" >> /usr/local/etc/php/conf.d/xdebug.ini

COPY php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

COPY php/mailcatcher.ini /usr/local/etc/php/conf.d/mailcatcher.ini

COPY bootstrap.sh /usr/local/bin/bootstrap.sh

COPY droproot.sh /usr/local/bin/droproot

RUN usermod -s /bin/bash www-data

RUN sed -i 's/exec.*//' /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["bootstrap.sh"]
CMD ["apache2-foreground"]
