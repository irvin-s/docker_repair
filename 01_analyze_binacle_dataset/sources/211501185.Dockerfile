FROM php:5.6-fpm
MAINTAINER Michaël Perrin <michael.perrin84@gmail.com>

RUN apt-get update \
    && apt-get install -y \
        git \
        unzip

# Necessary extensions for Symfony
RUN apt-get update \
    && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install \
        intl \
        opcache \
    && docker-php-ext-enable \
        intl \
        opcache

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

# Necessary PHP configuration for Symfony
RUN echo "date.timezone = Europe/Paris" >> /usr/local/etc/php/conf.d/symfony.ini

WORKDIR "/var/www/symfony_project"

ENTRYPOINT ["./docker-entrypoint.sh"]

EXPOSE 8080
