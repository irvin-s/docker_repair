FROM phusion/baseimage
MAINTAINER Yosh de Vos "yosh@elzorro.nl"
ENV RELEASE_DATE 2016-06-10

# Install base packages
RUN export LANG=en_US.UTF-8 && \
    export DEBIAN_FRONTEND="noninteractive" && \
    apt-get update && \
    apt-get -yq install python-software-properties && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get -yq install --no-install-recommends \
        php7.0-cli \
        php7.0-curl \
        php7.0-gd \
        php7.0-mcrypt \
        php7.0-mysql \
        php7.0-intl \
        php7.0-json \
        php7.0-opcache \
        php7.0-pgsql \
        php7.0-sqlite3 \
        php7.0-xml \
        subversion git curl zip unzip acl && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# Install composer
RUN COMPOSER_HOME=/usr/local/composer curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Run tests
ADD dist/tests/php70.sh /test.sh
RUN /test.sh && rm /test.sh
