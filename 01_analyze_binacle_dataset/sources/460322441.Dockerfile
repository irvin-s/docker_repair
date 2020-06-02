FROM debian:jessie

MAINTAINER cedric.olivier@free.fr

ENV JEEDOM_DB_HOST localhost
ENV JEEDOM_DB_PASSWORD jeedom
ENV SHELL_ROOT_PASSWORD jeedom

RUN echo "mysql-server mysql-server/root_password password ${JEEDOM_DB_PASSWORD}" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password ${JEEDOM_DB_PASSWORD}" | debconf-set-selections

RUN apt-get update && apt-get install -y \
	adduser \
	build-essential \
	cron \
	curl \
	libarchive-dev \
	libav-tools \
	libjsoncpp-dev \
	libpcre3-dev \
	git \
	libssh2-php \
	libtinyxml-dev \
	libudev1 \
	libxml2 \
	locales \
	miniupnpc \
	mysql-client \
	mysql-common \
	mysql-server \
	mysql-server-core \
	net-tools \
	nginx-common \
	nginx-full \
	nodejs \
	npm \
	ntp \
	openssh-server \
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

# modification de la configuration PHP pour un temps d'exécution allongé et le traitement de fichiers lourds
RUN sed -i "s/max_execution_time = 30/max_execution_time = 300/g" /etc/php5/fpm/php.ini
RUN sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 1G/g" /etc/php5/fpm/php.ini
RUN sed -i "s/post_max_size = 8M/post_max_size = 1G/g" /etc/php5/fpm/php.ini

# installation nginx
RUN mkdir -p /usr/share/nginx/www

# téléchargement de l'archive
#RUN cd /usr/share/nginx/jeedom/ && wget --no-check-certificate -O jeedom.zip https://market.jeedom.fr/jeedom/stable/jeedom.zip
RUN cd /usr/share/nginx/www && git clone https://github.com/jeedom/core.git jeedom

# ajout au préalable d'un dossier tmp
RUN mkdir -p /usr/share/nginx/www/jeedom/tmp

# définition des droits utilisateur/groupes/autres de manière récursif
RUN chmod 755 -R /usr/share/nginx/www/jeedom

# délégation des droits pour l'utilisateur www-data de manière récursif
RUN chown -R www-data:www-data /usr/share/nginx/www/jeedom

# ajout de l'utilisateur www-data au group dialout (pour piloter la connexion 3G éventuelle)
RUN adduser www-data dialout

RUN echo "www-data ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# on copie le fichier de configuration d'exemple 
RUN cp /usr/share/nginx/www/jeedom/core/config/common.config.sample.php /usr/share/nginx/www/jeedom/core/config/common.config.php

# on modifie le contenu avec les paramètres fixés lors de la configuration de l'utilisateur mysql dédié (cf. "Bases de données mysql")
RUN sed -i "s/#PASSWORD#/${JEEDOM_DB_PASSWORD}/g" /usr/share/nginx/www/jeedom/core/config/common.config.php

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh


RUN sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config

#ADD nginx.conf /etc/nginx/sites-available/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN echo "root:${SHELL_ROOT_PASSWORD}" | chpasswd

RUN mkdir -p /var/run/sshd /var/log/supervisor

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN echo "* * * * * su --shell=/bin/bash - www-data -c 'nice -n 19 /usr/bin/php /usr/share/nginx/www/jeedom/core/php/jeeCron.php' >> /dev/null" | crontab -

WORKDIR /usr/share/nginx/www/jeedom

EXPOSE 80 8070 8083 9001 443 22 10000 17100
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]

