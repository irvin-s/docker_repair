FROM boomtownroi/data-volume:latest

# Add your name if you find yourself here
LABEL maintainer="jared@boomtownroi.com"

ENV ALLOW_DEBUG true

# Install nginx and have it forward logs to Docker
RUN add-apt-repository -y ppa:nginx/stable &2> /dev/null
# JWS CNS-5171: Add the PPA for the repo providing PHP 5.6
# We use 5.6 because 5.5 is EOL and is difficult to install on 16.04
RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get update && \
    apt-get install -y git php5.6-fpm php5.6-mysql php5.6-curl php5.6-gd \
    php5.6-intl php5.6-mbstring php-pear php-imagick php5.6-imap php5.6-mcrypt php-memcached \
    g++ cpp php5.6-dev \
    php5.6-pspell php5.6-recode php5.6-tidy php5.6-xmlrpc php5.6-xsl php-xdebug netcat && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install & configure the 51Degrees extension
RUN cd / && \
    git clone https://github.com/51Degrees/Device-Detection.git

RUN cd Device-Detection/php/pattern && \
    phpize && \
    ./configure && \
    make install

# Clean up
RUN cd / && \
    rm -rf Device-Detection && \
    apt-get remove -y git

COPY root /

RUN phpenmod opcache && phpdismod xdebug

VOLUME /var/run/fpm/
