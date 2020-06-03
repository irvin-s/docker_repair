FROM charlieliu/php:latest  
RUN docker-php-ext-install pdo && docker-php-ext-install pdo_mysql  
CMD ["apache2-foreground"]

