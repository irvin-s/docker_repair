FROM php:7.0  
  
RUN apt-get update \  
&& apt-get install -y curl \  
git \  
zlib1g-dev \  
&& pecl install xdebug \  
&& docker-php-ext-install zip \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN curl -sS https://getcomposer.org/installer | php && \  
mv composer.phar /usr/local/bin/composer

