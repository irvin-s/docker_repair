# This container should be used for any/all CLI processes
# including cron, queues, etc.
FROM realpage/php:7.1-alpine

# Copy the application files to the container
ADD . /var/www/html

WORKDIR /var/www/html

# Install Composer dependencies
RUN apk add --update --no-cache git zip unzip \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Composer
RUN php /var/www/html/infrastructure/install_composer.php

# Ownership of the app dir for www-data
RUN chown -R www-data:www-data /var/www/html

# Run composer as www-data
USER www-data

# parallel dependency installation
RUN composer global require hirak/prestissimo \
    # production-ready dependencies
    && composer install  --no-interaction --optimize-autoloader --no-dev --prefer-dist

# Switch back to root
USER root

# Remove composer installation dependencies
RUN apk del libmcrypt git zip unzip

# Put php artisan schedule:run in a crontab
RUN echo "*       *       *       *       *       php /var/www/html/artisan schedule:run" > /etc/crontabs/www-data
