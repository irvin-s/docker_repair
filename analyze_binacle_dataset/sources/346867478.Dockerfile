# Pantheon 7.0 appserver mock for Kalabox
#
# docker build -t kalabox/pantheon-appserver:70 .
# docker run -d -e FRAMEWORK=backdrop kalabox/pantheon-appserver:70

FROM php:7.0-fpm

# Install the PHP extensions we need
RUN apt-get update && apt-get install -y \
    bzip2 \
    libbz2-dev \
    libc-client2007e-dev \
    libjpeg-dev \
    libkrb5-dev \
    libldap2-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libpng12-dev \
    libpq-dev \
    libxml2-dev \
    mysql-client \
    imagemagick \
    xfonts-base \
    xfonts-75dpi \
  && pecl install imagick \
  && pecl install oauth-2.0.2 \
  && pecl install redis-3.0.0 \
  && pecl install xdebug \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
  && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
  && docker-php-ext-enable imagick \
  && docker-php-ext-enable oauth \
  && docker-php-ext-enable redis \
  && docker-php-ext-enable xdebug \
  && docker-php-ext-install \
    bcmath \
    bz2 \
    calendar \
    gd \
    imap \
    ldap \
    mcrypt \
    mbstring \
    mysqli \
    opcache \
    pdo \
    pdo_mysql \
    soap \
    zip \
  && cd /tmp && curl -O 'http://download.gna.org/wkhtmltopdf/0.12/0.12.2/wkhtmltox-0.12.2_linux-jessie-amd64.deb' \
  && dpkg -i /tmp/wkhtmltox-0.12.2_linux-jessie-amd64.deb \
  && mkdir -p /srv/bin && ln -s /usr/local/bin/wkhtmltopdf /srv/bin/wkhtmltopdf \
  && cd /srv/bin \
  && curl -fsSL "https://github.com/Medium/phantomjs/releases/download/v2.1.1/phantomjs-2.1.1-linux-x86_64.tar.bz2" | tar -xjv \
  && mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /srv/bin/phantomjs \
  && rm -rf phantomjs-2.1.1-linux-x86_64 && rm -f phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  && chmod +x /srv/bin/phantomjs \
  && apt-get -y clean \
  && apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* && rm -rf && rm -rf /var/lib/cache/* && rm -rf /var/lib/log/* && rm -rf /tmp/*
