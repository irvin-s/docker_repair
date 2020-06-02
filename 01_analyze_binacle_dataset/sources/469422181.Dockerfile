FROM php:7.2.5-fpm

WORKDIR "/application"

RUN apt-get update --fix-missing

RUN echo "[ ***** ***** ***** ] - Installing each item in new command to use cache and avoid download again ***** ***** ***** "
RUN apt-get install -y apt-utils
RUN apt-get install -y libfreetype6-dev
RUN apt-get install -y libjpeg62-turbo-dev
RUN apt-get install -y libcurl4-gnutls-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y freetds-dev
RUN apt-get install -y git
RUN apt-get install -y curl
RUN apt-get install -y supervisor
RUN apt-get install -y libpq-dev

RUN echo "[ ***** ***** ***** ] - Installing PHP Dependencies ***** ***** ***** "
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install soap
RUN docker-php-ext-install calendar

RUN docker-php-ext-configure pgsql --with-pgsql=/usr/local/pgsql \
  && docker-php-ext-configure pdo_pgsql --with-pgsql \
  && docker-php-ext-install pgsql pdo_pgsql

WORKDIR "/tmp"

RUN ls -la /tmp
RUN curl --silent --show-error https://getcomposer.org/installer | php
RUN ls -la /tmp/composer.phar
RUN mv /tmp/composer.phar /usr/local/bin/
RUN ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

WORKDIR "/application"

COPY ./api /application

COPY ./docker/php-fpm/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

RUN chmod 777 /usr/local/bin/docker-entrypoint.sh \
    && ln -s /usr/local/bin/docker-entrypoint.sh /