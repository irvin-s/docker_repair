FROM php:5.6-cli
MAINTAINER Jim Phillips <jim.phillips@goldenfrogtech.com>

# Update APT
RUN apt-get update

# Prepare PHP5
RUN apt-get install -y openssl libcurl4-openssl-dev libgd-dev libmcrypt-dev \
    && docker-php-ext-install curl gd mcrypt json pdo_mysql

# Install Cron
RUN apt-get install -y cron

# Create App Directory
WORKDIR /app
ADD . /app

# Install Configurations
COPY docker_cfg.php cfg.php

# Connect Wallet Transaction
VOLUME /app/transactions

CMD ["/app/start"]
