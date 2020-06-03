FROM php:7.0-fpm
WORKDIR /tmp

# Install php exts and their dependencies
RUN apt-get remove imagemagick

RUN apt-get update && \
    apt-get install -y \
      libpng-dev \
      libmcrypt-dev \
      libssl-dev \
      libcurl4-openssl-dev \
      pkg-config \
      libxml2-dev \
      libyaml-dev \
      libmagickwand-dev \
      curl

RUN docker-php-ext-install gd mcrypt mbstring xml mysqli pdo_mysql zip
RUN pecl install imagick-beta redis yaml
RUN docker-php-ext-enable imagick redis yaml

# Remove the build-time deps
RUN apt-get remove -y \
      libpng-dev \
      libmcrypt-dev \
      libssl-dev \
      libcurl4-openssl-dev \
      pkg-config \
      libxml2-dev \
      libyaml-dev \
      libmagickwand-dev

# Install some other needed stuff
RUN apt-get install -y git nginx

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Make Composer not complain about root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install Composer dependencies
WORKDIR /app
COPY composer* ./
RUN composer install --no-autoloader --no-scripts

# Copy code to the docker container and run it
COPY . .
RUN composer dump-autoload

# Shrink the image size by removing deps that aren't needed anymore
RUN apt-get autoremove -y

# Configure nginx
COPY ./docker/nginx-site /etc/nginx/sites-enabled/default

# Do some stuff for error logging
COPY ./docker/php-fpm.conf /usr/local/etc/php-fpm.d/enable-logging.conf

# Make some dirs for mount points
RUN mkdir -p /app/storage /app/storage/logs /app/storage/framework /app/boostrap

# Fix permissions for some directories
RUN chown -R www-data /app/storage
RUN chown -R www-data /app/bootstrap

# Expose the nginx port
EXPOSE 80

# Start things
CMD [ "bash", "./docker-entrypoint.sh" ]
