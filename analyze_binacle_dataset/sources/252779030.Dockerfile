FROM php:7.2  
  
RUN apt-get update && \  
apt-get install -y --force-yes \  
libfreetype6-dev \  
libjpeg62-turbo-dev \  
libzip-dev \  
libmcrypt-dev \  
libc-client-dev \  
libkrb5-dev \  
cron \  
inotify-tools \  
curl \  
libcurl4-gnutls-dev \  
&& apt-get clean  
  
#################################################  
# PHP EXTENSIONS  
#################################################  
RUN docker-php-ext-configure \  
imap --with-kerberos --with-imap-ssl  
  
RUN docker-php-ext-configure \  
gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/  
  
RUN docker-php-ext-install \  
bcmath \  
mbstring \  
zip \  
opcache \  
pdo \  
pdo_mysql \  
opcache \  
json \  
imap \  
gd \  
curl \  
exif \  
pcntl  
  
#################################################  
# PHP MONGODB EXTENSION  
#################################################  
RUN pecl install mongodb \  
&& docker-php-ext-enable mongodb  
  
#################################################  
# PHP REDIS EXTENSION  
#################################################  
RUN pecl install -o -f redis \  
&& rm -rf /tmp/pear \  
&& docker-php-ext-enable redis  
  
#################################################  
# Install composer and add its bin to the PATH.  
#################################################  
RUN curl -s http://getcomposer.org/installer | php && \  
echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \  
mv composer.phar /usr/local/bin/composer  
  
RUN rm -r /var/lib/apt/lists/*  
  
WORKDIR /var/www

