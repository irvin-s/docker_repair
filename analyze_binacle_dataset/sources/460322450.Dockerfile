FROM debian:jessie

MAINTAINER cedric.olivier@free.fr

RUN apt-get update && apt-get install -y \
	build-essential \
	cron \
	curl \
	libarchive-dev \
	libav-tools \
	libjsoncpp-dev \
	libpcre3-dev \
	libssh2-php \
	libtinyxml-dev \
	libudev1 \
	libxml2 \
	locales \
	miniupnpc \
	mysql-client \
	net-tools \
	nginx-common \
	nginx-full \
	nodejs \
	npm \
	ntp \
	php5-cli \
	php5-common \
	php5-curl \
	php5-dev \
	php5-fpm \
	php5-json \
	php5-mysql \
	php-pear \
	python-serial \
	sudo \
	supervisor \
	systemd \
	unzip \
	usb-modeswitch \
	wget

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8

#RUN pecl install oauth

RUN apt-get autoremove

# Configuration nginx
COPY nginx_default /etc/nginx/sites-available/default
RUN touch /etc/nginx/sites-available/jeedom_dynamic_rule && chmod 777 /etc/nginx/sites-available/jeedom_dynamic_rule

# Configuration nginx_ssl
RUN openssl genrsa -out jeedom.key 2048
RUN openssl req \
	-new \
	-subj "/C=FR/ST=France/L=Paris/O=jeedom/OU=JE/CN=jeedom" \
	-key jeedom.key \
	-out jeedom.csr && \
   openssl x509 -req -days 9999 -in jeedom.csr -signkey jeedom.key -out jeedom.crt

RUN mkdir /etc/nginx/certs && \
	cp jeedom.key /etc/nginx/certs && \
	cp jeedom.crt /etc/nginx/certs && \
	rm jeedom.key jeedom.crt

COPY nginx_default_ssl /etc/nginx/sites-enabled/default_ssl


# Configuration php
# modification de la configuration PHP pour un temps d'exécution allongé et le traitement de fichiers lourds
RUN sed -i "s/max_execution_time = 30/max_execution_time = 300/g" /etc/php5/fpm/php.ini
RUN sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 1G/g" /etc/php5/fpm/php.ini
RUN sed -i "s/post_max_size = 8M/post_max_size = 1G/g" /etc/php5/fpm/php.ini
RUN echo "extension=oauth.so" >> /etc/php5/fpm/php.ini

# ajout de l'utilisateur www-data au group dialout (pour piloter la connexion 3G éventuelle)
RUN adduser www-data dialout && adduser www-data sudo

RUN echo "www-data ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN echo "* * * * * su --shell=/bin/bash - www-data -c '/usr/bin/php /usr/share/nginx/www/jeedom/core/php/jeeCron.php' >> /dev/null 2>&1" | crontab -

EXPOSE 80 8070 8083 9001 443 10000 17100
CMD ["/usr/bin/supervisord"]

