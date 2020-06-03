FROM ubuntu:16.04  
MAINTAINER Ashley Hutson <asheliahut@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
curl \  
git \  
nginx \  
php-fpm \  
php-cli \  
php-curl \  
php-intl \  
php-json \  
php-mbstring \  
php-mcrypt \  
php-mongodb \  
php-zip \  
php-xml  
  
RUN mkdir -p /data/www && \  
chown -R www-data:www-data /data/www  
  
ADD nginx.conf /etc/nginx/  
ADD default /etc/nginx/sites-enabled/  
ADD 99-custom.ini /etc/php/7.0/fpm/conf.d/  
  
VOLUME /data/www  
  
#Set port  
EXPOSE 80 443  
  
ENTRYPOINT service php7.0-fpm start; nginx  

