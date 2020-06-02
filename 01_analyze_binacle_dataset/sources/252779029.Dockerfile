FROM php:7.1-fpm  
  
RUN apt-get update && \  
apt-get install -y --force-yes \  
libfreetype6-dev \  
libjpeg62-turbo-dev \  
libpng12-dev \  
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
mcrypt \  
bcmath \  
mbstring \  
zip \  
opcache \  
pdo \  
pdo_mysql \  
opcache \  
mysqli \  
json \  
imap \  
gd \  
curl \  
exif  
  
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
  
RUN usermod -u 1000 www-data  
  
WORKDIR /var/www  
  
CMD ["php-fpm"]  
  
EXPOSE 9000

