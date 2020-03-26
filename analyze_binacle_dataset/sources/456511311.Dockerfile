FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Ibrahim Zehhaf <ibrahim.zehhaf.pro@gmail.com>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    vim \
    git \
    nginx \
    ssh \
    zip \
    unzip \
    imagemagick

# install php
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php7.3.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    php7.3 \
    php7.3-fpm \
    php7.3-mysql \
    php7.3-curl \
    php7.3-json \
    php7.3-xml \
    php7.3-zip \
    php7.3-opcache \
    php7.3-imagick


# install composer
RUN curl -k -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir /var/www/mawaqit
WORKDIR /var/www/mawaqit

ENTRYPOINT nginx && service php7.3-fpm start && /bin/bash