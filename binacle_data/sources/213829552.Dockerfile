FROM ubuntu
MAINTAINER "Alexander Trauzzi" <alexander@gmail.com>

WORKDIR /tmp

RUN apt-get update -y
ADD /laravel /var/www

RUN apt-get install -y php5-mongo php5-mysql php5-pgsql php5-redis php5-json php5-mcrypt php5-curl
RUN php5enmod mcrypt

RUN apt-get install -y php5-cli git

ADD /images/php-cli/php.ini /etc/php5/cli/php.ini
ADD /images/php-cli/entrypoint.sh /entrypoint.sh

WORKDIR /
RUN php -r "readfile('https://getcomposer.org/installer');" | php

WORKDIR /var/www
ENTRYPOINT ["/entrypoint.sh"]