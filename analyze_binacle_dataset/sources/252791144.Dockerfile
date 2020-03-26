FROM php:5.4-fpm  
  
MAINTAINER tiagocyberduck@cyber-duck.co.uk  
  
RUN apt-get update && \  
apt-get install -y --force-yes --no-install-recommends \  
libmemcached-dev \  
libz-dev \  
libpq-dev \  
libjpeg-dev \  
libpng12-dev \  
libfreetype6-dev \  
libssl-dev \  
libmcrypt-dev \  
openssh-server \  
git \  
cron \  
nano  
  
# Install the PHP mcrypt extention  
RUN docker-php-ext-install mcrypt  
  
# Install the PHP zip extention  
RUN docker-php-ext-install zip  
  
# Install the PHP legacy database drivers  
RUN docker-php-ext-install mysql mysqli  
  
# Install the PHP pdo and pdo_mysql extention  
RUN docker-php-ext-install pdo pdo_mysql  
  
# Install the PHP pdo_pgsql extention  
RUN docker-php-ext-install pdo_pgsql  
  
#####################################  
# GD:  
#####################################  
  
# Install the PHP gd library  
RUN docker-php-ext-install gd && \  
docker-php-ext-configure gd \  
\--enable-gd-native-ttf \  
\--with-jpeg-dir=/usr/lib \  
\--with-freetype-dir=/usr/include/freetype2 && \  
docker-php-ext-install gd  
  
ADD ./express.ini /usr/local/etc/php/conf.d  
  
RUN usermod -u 1000 www-data  
  
WORKDIR /var/www  
  
EXPOSE 9000  
  
CMD ["php-fpm"]

