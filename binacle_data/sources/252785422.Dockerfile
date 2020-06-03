FROM php:5-apache  
RUN docker-php-ext-install pdo pdo_mysql  
COPY . /var/www/html/cmu_slider/  
VOLUME /var/www/html/cmu_slider/img

