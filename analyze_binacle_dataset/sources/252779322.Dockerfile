FROM php:5-cli  
  
RUN apt-get update && apt-get install -y libmcrypt-dev  
RUN docker-php-ext-install mbstring mcrypt pdo pdo_mysql  
  
WORKDIR /app  
USER www-data  
  
ENTRYPOINT ["php", "artisan"]  
CMD ["env"]  

