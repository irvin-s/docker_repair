FROM phusion/baseimage
MAINTAINER Yosh de Vos "yosh@elzorro.nl"
ENV RELEASE_DATE 2016-06-10

# Install php and base packages
RUN export DEBIAN_FRONTEND="noninteractive" && \
    apt-get update && \
    apt-get -yq upgrade && \
    apt-get -yq install --no-install-recommends \
        php5-cli \
        php5-curl \
        php5-gd \
        php5-mcrypt \
        php5-mysql \
        php5-intl \
        php5-json \
        php5-pgsql \
        php5-sqlite \
        subversion git curl zip unzip acl && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# Install composer
RUN COMPOSER_HOME=/usr/local/composer curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable mcrypt
RUN php5enmod mcrypt

# Run tests
ADD dist/tests/php55.sh /test.sh
RUN /test.sh && rm /test.sh
