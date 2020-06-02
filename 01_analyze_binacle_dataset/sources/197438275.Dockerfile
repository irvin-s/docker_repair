FROM php:5.6-cli

MAINTAINER Luis Fernando Gomes <dev@luiscoms.com.br>

# Install extensions
RUN apt-get update \
		&& apt-get install -y \
		git \
		zlib1g-dev

# Install Composer
	# && php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '781c98992e23d4a5ce559daf0170f8a9b3b91331ddc4a3fa9f7d42b6d981513cdc1411730112495fbf9d59cffbf20fb2') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); }"
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
	&& php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
	&& php -r "unlink('composer-setup.php');"
# RUN curl -sS https://getcomposer.org/installer | php \
# 	&& mv composer.phar /usr/local/bin/composer

ENV COMPOSER_HOME=/opt/composer

ENV PATH=${PATH}:${COMPOSER_HOME}/vendor/bin

WORKDIR /release/

# Setup timezone to America/Sao_Paulo
RUN cat /usr/src/php/php.ini-production | sed 's/^;\(date.timezone.*\)/\1 \"America\/Sao_Paulo\"/' > /usr/local/etc/php/php.ini

# install global libraries
RUN docker-php-ext-install zip && \
		composer global require \
			phpunit/phpunit:~4 \
			squizlabs/php_codesniffer \
			humbug/humbug:~1.0@dev

# Install xdebug
RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug
