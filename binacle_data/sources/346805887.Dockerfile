# Notes: TODO

FROM ubuntu:14.04
LABEL maintainer="Charlie Drage <charlie@charliedrage.com>"

ENV VERSION 3.4.8-1

RUN apt-get update && apt-get install -y \
	wget \
	git \
	supervisor \
	mysql-client \
	nginx \
	php5-fpm \
	php5-mcrypt \
	php5-mysqlnd \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#!## PDNS ###
RUN cd /tmp && wget https://downloads.powerdns.com/releases/deb/pdns-static_${VERSION}_amd64.deb && dpkg -i pdns-static_${VERSION}_amd64.deb && rm pdns-static_${VERSION}_amd64.deb
RUN useradd --system pdns

COPY assets/nginx/nginx.conf /etc/nginx/nginx.conf
COPY assets/nginx/vhost.conf /etc/nginx/sites-enabled/vhost.conf
COPY assets/nginx/fastcgi_params /etc/nginx/fastcgi_params

COPY assets/php/php.ini /etc/php5/fpm/php.ini
COPY assets/php/php-cli.ini /etc/php5/cli/php.ini

COPY assets/pdns/pdns.conf /etc/powerdns/pdns.conf
COPY assets/pdns/pdns.d/ /etc/powerdns/pdns.d/
COPY assets/mysql/pdns.sql /pdns.sql

#!## PHP/Nginx ###
RUN rm /etc/nginx/sites-enabled/default
RUN php5enmod mcrypt
RUN mkdir -p /var/www/html/ \
	&& cd /var/www/html \
	&& git clone https://github.com/poweradmin/poweradmin.git . \
	&& git checkout 95017a780d71805ee647eb732c4c2e9fbbe9e6c1 \
	&& rm -R /var/www/html/install

COPY assets/poweradmin/config.inc.php /var/www/html/inc/config.inc.php
COPY assets/mysql/poweradmin.sql /poweradmin.sql
RUN chown -R www-data:www-data /var/www/html/

#!## SUPERVISOR ###
COPY assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /start.sh

EXPOSE 53 80 8001
EXPOSE 53/udp

CMD ["/bin/bash", "/start.sh"]
