FROM php:5.5-cli

# install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Install git
RUN apt-get update
RUN apt-get install -y git

# Goto temporary directory.
WORKDIR /tmp

# Run composer and phpunit installation.
RUN composer selfupdate && \
  composer require "phpunit/phpunit:~4.6.10" && \
  ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit

# Set up the application directory.
VOLUME ["/app"]
WORKDIR /app

# Set up the command arguments.
# ENTRYPOINT ["/usr/local/bin/phpunit"]
# CMD ["--help"]