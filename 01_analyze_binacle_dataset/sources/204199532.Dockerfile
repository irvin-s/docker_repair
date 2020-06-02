FROM php:5.6

MAINTAINER tristan@tristanpenman.com

# Install dependencies
RUN apt-get update \
&& apt-get install -y unzip \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Composer
RUN cd /usr/local/bin \
&& php -r "readfile('https://getcomposer.org/installer');" | php \
&& ln -sf /usr/local/bin/composer.phar /usr/local/bin/composer

# Install php-webdriver and PHPUnit
COPY composer.json /wd/composer.json
RUN cd /wd \
&& composer install \
&& ln -sf /wd/vendor/phpunit/phpunit/phpunit /usr/local/bin/phpunit

# Setup working directory
RUN mkdir -p /wd/src
WORKDIR /wd/src

# Set up entrypoint script
ENV SCRIPTS_DIR /scripts
RUN mkdir -p /scripts/entrypoint.d
COPY docker-entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh
ENTRYPOINT ["/scripts/entrypoint.sh"]

CMD ["phpunit","."]
