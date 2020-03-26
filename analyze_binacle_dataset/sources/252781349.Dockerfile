FROM bananabb/ubuntu-base:base.2.0.0  
MAINTAINER BananaBb  
  
# Install nginx & packages & php  
RUN sudo apt-get update \  
&& sudo apt-get install -y \  
nginx \  
supervisor \  
cron \  
libpcre3-dev \  
python-software-properties \  
software-properties-common \  
php-fpm \  
php-mysql \  
php-mcrypt \  
php-gd \  
php-memcached \  
php-curl \  
php-mbstring \  
php-zip \  
php-opcache \  
php-xdebug \  
php-pear \  
php-dev \  
php7.0-soap \  
&& pecl install mongodb  
  
# Build Folder  
RUN mkdir -p /var/www/public \  
/var/log/supervisor \  
/etc/nginx \  
/var/run/php-fpm \  
/etc/php/conf.d  
  
# Setup File  
RUN sudo rm /etc/nginx/sites-available/default \  
&& sudo cp /usr/share/nginx/html/index.html /var/www/public/ \  
&& echo "extension=mongodb.so" >> /etc/php/7.0/fpm/php.ini \  
&& echo "extension=mongodb.so" >> /etc/php/7.0/cli/php.ini  
  
# File setting  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
COPY Default /etc/nginx/sites-available/default  
COPY installer composer-setup.php  
  
# Setup Composer  
RUN php composer-setup.php \  
&& mv composer.phar /usr/local/bin/composer \  
&& rm composer-setup.php  
  
EXPOSE 80 443  
CMD ["/usr/bin/supervisord"]

