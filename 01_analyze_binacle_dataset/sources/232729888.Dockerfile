FROM php:7.1-fpm

LABEL maintainer "Renato Marinho <renato.marinho@s2move.com>"

RUN apt-get update

RUN apt-get install -y \
	git \
    libz-dev \
	libcurl4-gnutls-dev \
	libmcrypt-dev  \
	libicu-dev \
    zip \
    unzip \
    gnupg \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install iconv \
	&& docker-php-ext-install mcrypt \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install mbstring \
    && docker-php-ext-install curl \
    && docker-php-ext-install zip


# Install nodejs
RUN apt-get install -y software-properties-common
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs npm
RUN npm install --global gulp gulp-cli

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && sed -i '1 a xdebug.remote_autostart=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_port=9090' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_host=127.0.0.1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.profiler_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.profiler_output_dir=/var/log/xdebug' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.idekey=PHPSTORM' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install php-cs-fixer
RUN curl -L https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.0.0/php-cs-fixer.phar -o /usr/local/bin/php-cs-fixer
RUN chmod a+x /usr/local/bin/php-cs-fixer

RUN apt-get clean

EXPOSE 9200 9000 9090 80

CMD ["php-fpm"]

