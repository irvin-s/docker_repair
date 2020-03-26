FROM php:7.1-apache  
RUN docker-php-ext-install mysqli pdo pdo_mysql  
RUN rm -rf /var/lib/apt/lists/*  

