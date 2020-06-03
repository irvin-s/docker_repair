#############################
# Contest 3.4 Development
#
# Docker file to be used with Docker Compose. This will setup a complete development environment
#
#############################

FROM php:7.1-apache

MAINTAINER App-Arena GmbH <friends@app-arena.com>

# Set environment variables
ENV COMPOSER_ALLOW_SUPERUSER=1
#ENV PATH=$PATH:vendor/bin
ENV XDEBUGINI_PATH=/usr/local/etc/php/conf.d/xdebug.ini

# Apache configuration
RUN a2enmod rewrite
RUN service apache2 restart

# Install PHP extensions
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get update && apt-get install -y \
      build-essential \
      curl \
      git \
      libcurl4-openssl-dev \
      libicu-dev \
      libpq-dev \
      libpng-dev \
      libmcrypt-dev \
      mysql-client \
      libmysqlclient-dev \
      ruby-full \
      vim \
      nodejs \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install \
      curl \
      gd \
      intl \
      mbstring \
      mcrypt \
      mysqli \
      pcntl \
      pdo_mysql \
      zip \
      opcache

# Install package manager (bower and composer)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
    && npm install -g bower

# Dev dependencies
RUN su -c "gem install sass"
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

RUN echo "zend_extension="`find /usr/local/lib/php/extensions/ -iname 'xdebug.so'` > $XDEBUGINI_PATH
COPY ./build/docker/xdebug.ini /tmp/xdebug.ini
RUN cat /tmp/xdebug.ini >> $XDEBUGINI_PATH
RUN echo "xdebug.remote_host="`/sbin/ip route|awk '/default/ { print $3 }'` >> $XDEBUGINI_PATH


# Change uid and gid of apache to docker user uid/gid
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

# Install dependencies
WORKDIR /var/www/html
COPY composer.json package.json bower.json ./
RUN composer install && npm install --quiet && bower install --allow-root
