FROM phusion/baseimage:latest

MAINTAINER Paulo Dias <prbdias@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

# Install "software-properties-common" (for the "add-apt-repository")
RUN apt-get update && apt-get install -y \
    software-properties-common

# Add the "PHP 7" ppa
RUN add-apt-repository -y \
    ppa:ondrej/php

# Install PHP-CLI 7.1, some PHP extentions and some useful Tools with APT
RUN apt-get update && apt-get install -y --force-yes \
        php7.1-cli \
        php7.1-common \
        php7.1-curl \
        php7.1-json \
        php7.1-xml \
        php7.1-mbstring \
        php7.1-mcrypt \
        php7.1-mysql \
        php7.1-zip \
        php-memcached \
        php-xdebug \
        git \
        curl \
        nano \
        iputils-ping \
        zip \
        unzip


# Clean up, to free some space
RUN apt-get clean

# Add an alias for PHPUnit
RUN echo "alias phpunit='./vendor/bin/phpunit'" >> ~/.bashrc

# Install Composer
RUN curl -s http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/ \
    && echo "alias composer='/usr/local/bin/composer.phar'" >> ~/.bashrc

# Source the bash
RUN . ~/.bashrc

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV COMPOSER_ALLOW_SUPERUSER 1

ADD init.sh /sbin/init.sh
RUN chmod +x /sbin/init.sh
CMD ["/sbin/init.sh"]

WORKDIR /var/www