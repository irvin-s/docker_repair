FROM php:5.5

RUN apt-get update \
  && apt-get install -y libcurl4-openssl-dev sudo git libxslt-dev mercurial subversion zlib1g-dev graphviz zip libmcrypt-dev libicu-dev g++ libgd-dev libfreetype6-dev sqlite \
  && apt-get clean \
  && docker-php-ext-install soap \
  && docker-php-ext-install zip \
  && docker-php-ext-install xsl \
  && docker-php-ext-install mcrypt \
  && docker-php-ext-install mbstring \
  && docker-php-ext-install gettext \
  && docker-php-ext-install curl \
  && docker-php-ext-install mysql \
  && docker-php-ext-install pdo_mysql \
  && docker-php-ext-install json \
  && docker-php-ext-install intl \
  && docker-php-ext-install opcache \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
  && docker-php-ext-install gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash && apt-get install -y nodejs && apt-get clean