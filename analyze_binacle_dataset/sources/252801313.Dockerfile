FROM php:7.1-alpine  
MAINTAINER dyoshikawa  
  
# install PHP extensions  
RUN docker-php-ext-install pdo_mysql mysqli mbstring  
  
# install zip, unzip and composer  
RUN apk add -U zip unzip \  
&& curl -sS https://getcomposer.org/installer | php \  
&& mv composer.phar /usr/local/bin/composer  
  
# install composer plugin  
RUN composer global require hirak/prestissimo  
  
# create Laravel project  
RUN composer create-project --prefer-dist laravel/lumen /app  
WORKDIR /app  
  
# command  
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]

