FROM php:5.4-fpm
ARG TIMEZONE
ARG XDEBUG_REMOTE_HOST

RUN echo "deb http://httpredir.debian.org/debian jessie main" > /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    openssh-client \
    openssl \
    git \
    mysql-client \
    unzip \
    vim \
    zlib1g-dev \
    libicu-dev \
    g++ \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    make \
    libav-tools \
    gnupg \
    nodejs

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#RUN composer global require hirak/prestissimo
RUN composer --version

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini
RUN "date"

# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli
RUN docker-php-ext-install iconv mcrypt mbstring exif zip pcntl
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl


# install xdebug
RUN pecl install xdebug-2.4.1
RUN docker-php-ext-enable xdebug
RUN echo "error_reporting=E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_startup_errors=On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_errors=On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_host=${XDEBUG_REMOTE_HOST}" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.remote_addr_header=HTTP_XDEBUG_HOST" >> /usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini
RUN echo "xdebug.max_nesting_level=1200" >> /usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini

# install yarn
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn nodejs

COPY php.ini /usr/local/etc/php/
COPY bashrc.dist /var/www/.bashrc

RUN ln -s /var/www/.host/composer /var/www/.composer
RUN ln -s /var/www/.host/local /var/www/.local
RUN ln -s /var/www/.host/.npmrc /var/www/.npmrc
RUN ln -s /var/www/html/docker/data/.bash_history /var/www/.bash_history

RUN chown -R www-data: /var/www
RUN usermod -u $USER_ID www-data -s /bin/bash

RUN echo "10.5.0.5 localhost" >> /etc/hosts

WORKDIR /var/www/html/www
