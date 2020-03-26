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
        php5.6-cli \
        php5.6-curl \
        php5.6-gd \
        php5.6-mcryp \
        php5.6-mysql \
        php5.6-intl \
        php5.6-json \
        php5.6-opcache \
        php5.6-pgsql \
        php5.6-sqlite3 \
        php5.6-xml \
        subversion git curl zip unzip acl && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# Install composer
RUN COMPOSER_HOME=/usr/local/composer curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Run tests
ADD dist/tests/php56.sh /test.sh
RUN /test.sh && rm /test.sh
