FROM php:7.0.7-apache

MAINTAINER JianyingLi <lijy91@foxmail.com>

RUN apt-get update     \
 && apt-get install -y \
      libmcrypt-dev \
      libz-dev      \
      git           \
      cron          \
      vim           \
 && docker-php-ext-install \
      mcrypt    \
      mbstring  \
      pdo_mysql \
      zip       \
 && apt-get clean      \
 && apt-get autoclean  \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD _linux/var/spool/cron/crontabs/root /var/spool/cron/crontabs/root
RUN chown -R root:crontab /var/spool/cron/crontabs/root \
 && chmod 600 /var/spool/cron/crontabs/root
RUN touch /var/log/cron.log

RUN a2enmod rewrite && \
    a2enmod deflate

ADD _linux/etc/apache2/mods-available/deflate.conf /etc/apache2/mods-available/deflate.conf
RUN chown -R root:root /etc/apache2/mods-available/deflate.conf \
 && chmod 600 /etc/apache2/mods-available/deflate.conf

WORKDIR /app

RUN git clone --depth=1 https://github.com/swagger-api/swagger-ui.git public/vendor/swagger-ui

COPY ./composer.json /app/
COPY ./composer.lock /app/
RUN composer install --no-autoloader --no-scripts

COPY . /app

RUN rm -fr /var/www/html \
 && ln -s /app/public /var/www/html

RUN chown -R www-data:www-data /app \
 && chmod -R 0777 /app/storage      \
 && composer install

RUN chmod 777 ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
