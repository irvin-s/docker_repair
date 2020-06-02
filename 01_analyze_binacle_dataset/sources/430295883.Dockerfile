FROM sflive/base

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y \
    daemontools curl nginx mysql-server redis-server \
    php5-cli php5-json php5-fpm php5-intl php5-mysqlnd

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN echo "daemonize=no" > /etc/php5/fpm/pool.d/daemonize.conf
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

ADD vhost.conf /etc/nginx/sites-enabled/default
ADD php.ini /etc/php5/fpm/php.ini
ADD php.ini /etc/php5/cli/php.ini
ADD my.cnf /etc/mysql/my.cnf

ADD services/ /srv/services

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]