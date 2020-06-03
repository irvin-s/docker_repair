#############################
# Contest 3.4 Development
#
# Docker file to be used with Docker Compose. This will setup a complete development environment
#
#############################

FROM php:7.1-apache

MAINTAINER App-Arena GmbH <friends@app-arena.com>

# Set the locale
RUN apt-get clean && apt-get -y update && apt-get install -y locales && locale-gen en_US.UTF-8

# Set environment variables
ENV COMPOSER_ALLOW_SUPERUSER=1
#ENV LANG en_US.UTF-8
#ENV LANGUAGE en_US:en
#ENV LC_ALL en_US.UTF-8

# Install Ubuntu packages
RUN apt-get install -y \
        build-essential \
        curl \
        git \
        libcurl4-openssl-dev \
        libicu-dev \
        libmcrypt-dev \
        libmysqlclient-dev \
        libpng-dev \
        mysql-client \
        ruby-full \
        software-properties-common \
        vim \
        zip

# Install PHP and NodeJS
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y \
        nodejs \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install \
      curl \
      #fpm \
      gd \
      intl \
      json \
      mbstring \
      mcrypt \
      mysqli \
      pdo_mysql \
      zip \
      opcache \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && npm install -g bower \
    && mkdir /run/php \
    && apt-get remove -y --purge software-properties-common \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Dev dependecies
RUN curl -fsSL 'https://xdebug.org/files/xdebug-2.5.5.tgz' -o xdebug.tar.gz \
        && mkdir -p xdebug \
        && tar -xf xdebug.tar.gz -C xdebug --strip-components=1 \
        && rm xdebug.tar.gz \
        && ( \
        cd xdebug \
        && phpize \
        && ./configure --enable-xdebug \
        && make -j$(nproc) \
        && make install \
        ) \
        && rm -r xdebug \
        && docker-php-ext-enable xdebug
COPY ./build/docker/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
RUN su -c "gem install sass"

# Apache configuration
RUN a2enmod rewrite
RUN service apache2 restart

# Change uid and gid of apache to docker user uid/gid
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

# Install package dependencies
WORKDIR /var/www/html
COPY composer.json package.json bower.json ./
RUN composer install && npm install --quiet && bower install --allow-root

#COPY start-container /usr/local/bin/start-container
#RUN chmod +x usr/local/bin/start-container

#EXPOSE 80
#CMD ["start-container"]