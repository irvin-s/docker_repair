FROM kafebob/rpi-php-apache:5.6
LABEL maintainer="Luis Toubes <luis@toub.es>"
RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y \
  libicu-dev \
  xz-utils \
  git \
  zlib1g-dev \
  libgmp-dev \
  re2c \
  python \
  nodejs \
  libav-tools
RUN ln -s /usr/include/arm-linux-gnueabihf/gmp.h /usr/local/include/ \
  && docker-php-ext-install mbstring intl zip gmp gettext
RUN a2enmod rewrite
RUN curl -sS https://getcomposer.org/installer | php
COPY source/resources/php.ini /usr/local/etc/php/
COPY source/. /var/www/html/
COPY config.yml /var/www/html/config/
RUN php composer.phar install --prefer-dist \
  && npm install \
  && ./node_modules/.bin/bower --allow-root install \
  && ./node_modules/.bin/grunt \
  && chmod 777 /var/www/html/templates_c
ENV CONVERT=1
