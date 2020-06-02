# Dockerfile for WithSocial.com builds and any other PHP/Composer based project

FROM debian:stretch
MAINTAINER Ben Sampson <ben@myns.co>


RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    lsb-release \
    ca-certificates \
    curl \
    git \
    zip \
    unzip \
    sudo

ADD https://packages.sury.org/php/apt.gpg /etc/apt/trusted.gpg.d/php.gpg
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN chmod 664 /etc/apt/trusted.gpg.d/php.gpg

RUN apt-get update && \
    apt-get install -y \
    php7.3-bcmath \
    php7.3-fpm \
    php7.3-cli \
    php7.3-mbstring \
    php7.3-xml \
    php7.3-zip \
    php7.3-curl \
    php7.3-intl \
    php7.3-gd \
    php7.3-sqlite3 \
    php7.3-mysql \
    php7.3-pgsql \
    rubygems

RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

# Install Laravel Envoy
RUN composer global require "laravel/envoy=~1.0"

# Is this good?
RUN php -v && \
    git --version && \
    composer --version
