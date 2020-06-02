FROM php:7.1.9-fpm  
  
MAINTAINER fabien.gaubert@gmail.com  
  
ENV DISPLAY_ERROR 'Off'  
ENV XDEBUG_ENABLE 0  
ENV XDEBUG_HOSTIP 127.0.0.1  
ENV XDEBUG_PORT 9000  
RUN apt-get update && apt-get install -y \  
git \  
unzip \  
libssl-dev \  
pkg-config \  
curl libc6 libcurl3 zlib1g \  
librabbitmq-dev \  
libmagickwand-dev libmagickcore-dev \  
wget  
  
# Install Pgsql modules  
RUN buildDeps="libpq-dev libzip-dev libicu-dev" && \  
apt-get update && \  
apt-get install -y $buildDeps \--no-install-recommends && \  
rm -rf /var/lib/apt/lists/* && \  
docker-php-ext-install \  
pdo \  
pdo_pgsql \  
pgsql \  
sockets \  
intl  
  
# install pecl  
RUN pecl install amqp imagick xdebug  
RUN docker-php-ext-enable amqp imagick xdebug opcache intl  
  
# Set timezone  
RUN rm /etc/localtime  
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime  
  
# php config  
ADD php/php.ini /usr/local/etc/php/php.ini  
  
# pool config  
ADD php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf  
  
ADD start-container.d /start-container.d  
ADD start-container.sh /start-container.sh  
  
CMD ["bash", "/start-container.sh"]  
  
WORKDIR /var/www/symfony  

