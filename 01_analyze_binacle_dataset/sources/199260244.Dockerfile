FROM php:7-apache
RUN a2enmod rewrite headers && \
    docker-php-ext-install -j$(nproc) pdo_mysql
COPY *.php *.html *.css .htaccess /var/www/html/
RUN sed -i 's/host=localhost/host=dbserver/g' /var/www/html/db.php
