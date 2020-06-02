FROM php:5.6-apache
MAINTAINER Stian Soiland-Reyes <soiland-reyes@cs.manchester.ac.uk>

# Install apache/PHP for REST API
WORKDIR /usr/src
RUN tar xJfv php.tar.xz

RUN ln -s php-* php && cd /usr/src/php/ext/
WORKDIR /tmp
RUN curl -L http://pecl.php.net/get/memcached-2.2.0.tgz | tar zxfv - && mv memcached-* /usr/src/php/ext/memcached
RUN curl -L http://pecl.php.net/get/memcache-3.0.8.tgz | tar zxfv - && mv memcache-* /usr/src/php/ext/memcache
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libcurl4-openssl-dev libxslt1-dev libmemcached-dev libz-dev && \
    docker-php-ext-install xsl memcache memcached
# curl and json already installed?
RUN a2enmod rewrite

RUN rm -rf /var/www/html
#Install Linked Data API
ADD . /var/www/html
WORKDIR /var/www/html


# Silence warnings (Issue #13)
RUN echo "display_errors=0" > /usr/local/etc/php/conf.d/ops-warnings.ini
RUN echo "log_errors=1" >> /usr/local/etc/php/conf.d/ops-warnings.ini
RUN echo "html_errors=0" >> /usr/local/etc/php/conf.d/ops-warnings.ini

# Fixes https://github.com/openphacts/GLOBAL/issues/292
RUN echo "[Pcre]" > /usr/local/etc/php/conf.d/ops-pcre.ini
RUN echo "pcre.backtrack_limit=100000000" >> /usr/local/etc/php/conf.d/ops-pcre.ini
RUN echo "pcre.recursion_limit=100000000" >> /usr/local/etc/php/conf.d/ops-pcre.ini

RUN rm -rf /var/www/html/logs /var/www/html/cache && \
    mkdir /var/www/html/logs /var/www/html/cache && \
    chmod 777 /var/www/html/logs /var/www/html/cache && \
    chown -R www-data:www-data /var/www/html

CMD ["apache2-foreground"]
