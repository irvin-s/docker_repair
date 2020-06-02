FROM php:7.1.6-apache  
MAINTAINER Thomas Cheng <thomas@beamstyle.com.hk>  
  
RUN apt-get update && apt-get install -y \  
libmcrypt-dev \  
git \  
zlib1g-dev \  
libicu-dev \  
g++ \  
libsqlite3-dev \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Basic lumen packages  
RUN docker-php-ext-install \  
pdo \  
pdo_mysql \  
pdo_sqlite \  
opcache \  
intl \  
mcrypt \  
mbstring \  
mysqli \  
tokenizer \  
zip  
  
# Add php.ini for production  
COPY php/php.ini-production $PHP_INI_DIR/php.ini  
COPY apache/apache2.conf /etc/apache2/apache2.conf  
  
# Configuring Apache  
RUN rm /etc/apache2/sites-available/000-default.conf \  
&& rm /etc/apache2/sites-enabled/000-default.conf  
  
# Enable rewrite module  
RUN a2enmod rewrite  
RUN a2enmod expires  
RUN a2enmod headers  
  
WORKDIR /var/www/html  
  
# Download and Install Composer  
RUN curl -s http://getcomposer.org/installer | php \  
&& mv composer.phar /usr/local/bin/composer  
  
# Add vendor binaries to PATH  
ENV PATH=/var/www/html/vendor/bin:$PATH  

