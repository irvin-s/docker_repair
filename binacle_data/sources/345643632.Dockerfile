FROM ubuntu

# install curl and php
RUN apt-get install -y curl php5 php5-cli

# install composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/bin/composer

# Install phpunit
RUN mkdir /var/www/phpunit && cd /var/www/phpunit && composer require phpunit/phpunit=3.7.14

# install silex
RUN mkdir /var/www/silex && cd /var/www/silex && composer require silex/silex:~1.3

# install videlalvaro/php-amqplib
RUN mkdir /var/www/videlalvaro && cd /var/www/videlalvaro && composer require videlalvaro/php-amqplib:*

# add application source file
ADD index.php /var/www/silex/

# run PHP server
CMD php -S 0.0.0.0:80 -t /var/www/silex
