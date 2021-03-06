FROM php:7.2-fpm

RUN apt-get update \
    && apt-get install -y \
        apache2 \
        git \
        libapache2-mod-fastcgi \
        libmcrypt-dev \
        libmemcached-dev \
        mysql-client \
        nginx \
        procps \
        supervisor \
        unzip \
        valgrind \
        vim \
        wget \
        zip \
        zlib1g-dev \
    && pecl install mcrypt-1.0.0 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-install pcntl \
    && docker-php-ext-enable pcntl \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-enable mysqli \
    && docker-php-ext-enable pdo \
    && docker-php-ext-enable pdo_mysql \
    && docker-php-source delete \
    && rm -rf /var/lib/apt/lists/*

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
        && php composer-setup.php  --install-dir="/usr/bin" --filename=composer \
        && php -r "unlink('composer-setup.php');" \
        && composer self-update

ARG DD_TRACE_VERSION
ARG WEB_APP_PATH

COPY ${WEB_APP_PATH} /var/www

# Install DDTrace deb
ADD https://github.com/DataDog/dd-trace-php/releases/download/${DD_TRACE_VERSION}/datadog-php-tracer_${DD_TRACE_VERSION}-beta_amd64.deb datadog-php-tracer.deb
RUN dpkg -i datadog-php-tracer.deb

COPY Dockerfiles/php_nginx_default.conf /etc/nginx/sites-available/default
COPY Dockerfiles/supervisord-nginx-fpm.conf /etc/supervisord.conf
COPY Dockerfiles/php-dd-ext.ini /usr/local/etc/php/conf.d/php-dd-ext.ini


WORKDIR /var/www

RUN chmod -R a+w /var/www

RUN php -d memory_limit=-1 /usr/bin/composer update --no-dev

CMD [ "supervisord", "-n" ]
