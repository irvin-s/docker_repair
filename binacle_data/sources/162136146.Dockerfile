FROM alpine:3.8

# install packages
RUN apk add --no-cache curl php php-common php-curl php-phar php-mbstring \
php-pcntl php-json php-opcache php-fpm php php-openssl php-dom php-xml \
php-pdo_mysql openssl nginx runit

# Install Composer
RUN curl https://getcomposer.org/composer.phar > /usr/sbin/composer

# Copy configs
COPY container/php.ini /etc/php7/php.ini
COPY container/nginx.conf /etc/nginx/nginx.conf
COPY container/fpm.conf /etc/php7/php-fpm.conf

# set up runit
COPY container/runsvinit /sbin/runsvinit
RUN mkdir /tmp/nginx && mkdir -p /etc/service/nginx && echo '#!/bin/sh' >> /etc/service/nginx/run && \
echo 'nginx' >> /etc/service/nginx/run && chmod +x /etc/service/nginx/run && \
mkdir -p /etc/service/fpm && echo '#!/bin/sh' >> /etc/service/fpm/run && \
echo 'php-fpm7 -FR' >> /etc/service/fpm/run && chmod +x /etc/service/fpm/run && \
chmod +x /sbin/runsvinit
CMD ["/sbin/runsvinit"]
EXPOSE 80

# set up app; order of operations optimized for maximum layer reuse
RUN mkdir /var/app
COPY composer.lock /var/app/composer.lock
COPY composer.json /var/app/composer.json
RUN cd /var/app && php /usr/sbin/composer install --prefer-dist -o
COPY templates /var/app/templates
COPY public /var/app/public
COPY bootstrap /var/app/bootstrap
