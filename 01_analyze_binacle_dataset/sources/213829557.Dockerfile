FROM ubuntu
MAINTAINER "Alexander Trauzzi" <atrauzzi@gmail.com>

WORKDIR /tmp

RUN apt-get update -y
ADD /laravel /var/www

RUN apt-get install -y php5-mongo php5-mysql php5-pgsql php5-redis php5-json php5-mcrypt php5-curl
RUN php5enmod mcrypt

RUN apt-get install -y php5-fpm

ADD /images/php-fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD /images/php-fpm/php.ini /etc/php5/fpm/php.ini
ADD /images/php-fpm/www.conf /etc/php5/fpm/pool.d/www.conf

EXPOSE 9000
ENTRYPOINT ["/usr/sbin/php5-fpm", "-F", "-R"]
