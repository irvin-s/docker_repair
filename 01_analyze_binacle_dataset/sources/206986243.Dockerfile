FROM php:5.6-apache

MAINTAINER "Toshiki Inami <t-inami@arukas.io>"

ENV SLIM_VERSION "3.4.0"

# Install curl, git and supervisor, and then clean up
RUN apt-get update && apt-get install -y \
      git \
      supervisor \
    && rm -rf /var/lib/apt/lists/*

# Install Slim framework
WORKDIR /var/www/html
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer require slim/slim "^${SLIM_VERSION}" && \
    rm -rf /usr/local/bin/composer

# Enable mod_rewrite for apache2.2
RUN a2enmod rewrite

# Congigure apache2
COPY slim/.htaccess /var/www/html/.htaccess
COPY slim/slim-apache.conf /etc/apache2/sites-available/000-default.conf

# Add Slim default routing file
COPY slim/index.php /var/www/html/index.php

# Configure supervisord
RUN mkdir -p /etc/supervisor/conf.d/ && \
    mkdir -p /var/log/supervisor/
COPY supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose 80 for HTTP access
EXPOSE 80

# Start supervisord to controll processes
CMD ["/usr/bin/supervisord"]
