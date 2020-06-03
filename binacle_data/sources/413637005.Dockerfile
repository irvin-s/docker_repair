FROM ubuntu:12.04

VOLUME ["/var/www/html"]

RUN apt-get -qq update && \
      apt-get install -y -qq --no-install-recommends build-essential imagemagick  libmagickcore-dev libmagickwand-dev libssh2-1-dev \
      apache2 \
      php5 \
      php5-dev \
      libapache2-mod-php5 \
      php5-gd \
      php5-mcrypt \
      php5-mysql \
      php-pear

RUN pecl install imagick-2.2.2
RUN pecl install memcache
RUN pecl install ssh2-0.11.1

COPY php/imagick.ini /etc/php5/conf.d/imagick.ini
COPY php/memcache.ini /etc/php5/conf.d/memcache.ini
COPY php/ssh2.ini /etc/php5/conf.d/ssh2.ini

COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

EXPOSE 80
CMD ["/usr/local/bin/run"]
