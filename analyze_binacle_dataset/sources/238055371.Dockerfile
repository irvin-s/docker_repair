FROM php:7.0-apache
RUN docker-php-ext-install pdo_mysql
ADD index.php info.php backend.php frontend.html api.php /var/www/html/