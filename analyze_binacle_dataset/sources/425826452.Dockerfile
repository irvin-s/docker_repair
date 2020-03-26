FROM debian:stretch AS production
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	libapache2-mod-php \
	php-apcu \
	php-curl \
	php-gd \
	php-mbstring \
	php-mcrypt \
	php-mysql \
	php-xml \
	php-zip
COPY httpdocs /srv/abgeordnetenwatch.de/httpdocs
COPY provisioning/etc/apache2/sites-available/* /etc/apache2/sites-available/
RUN a2enmod \
	proxy_http \
	rewrite \
	ssl
RUN a2dissite 000-default
RUN a2ensite drupal
RUN mkdir -p /media/drupal-files/private
RUN mkdir -p /media/drupal-files/public
RUN chown -R www-data:www-data /media/drupal-files
RUN ln -sf /media/drupal-files/public /srv/abgeordnetenwatch.de/httpdocs/sites/default/files
VOLUME ["/media/drupal-files"]
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

FROM production AS development
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	curl \
	gettext \
	git \
	gnupg \
	make \
	mariadb-client \
	php-cli \
	php-xdebug
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs
ARG XDEBUG_REMOTE_CONNECT_BACK=1
COPY provisioning/etc/php/7.0/mods-available/development.ini /tmp/development.ini
RUN cat /tmp/development.ini | envsubst | tee /etc/php/7.0/mods-available/development.ini
RUN phpenmod development
COPY provisioning/etc/drush/* /etc/drush/
COPY provisioning/drush.phar /usr/local/bin/drush
RUN chmod +x /usr/local/bin/drush
WORKDIR /srv/abgeordnetenwatch.de
ENTRYPOINT ["provisioning/docker-entrypoint.sh"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
