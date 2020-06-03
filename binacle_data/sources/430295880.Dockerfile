FROM sflive/base

RUN apt-get install -y curl php5-cli php5-json php5-fpm php5-intl php5-mysqlnd 

RUN echo "daemonize=no" > /etc/php5/fpm/pool.d/daemonize.conf
RUN sed -e "s,127.0.0.1:9000,9000," -i /etc/php5/fpm/pool.d/www.conf

ADD php.ini /etc/php5/fpm/php.ini
ADD php.ini /etc/php5/cli/php.ini

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

EXPOSE 9000

ENTRYPOINT ["/usr/sbin/php5-fpm"]