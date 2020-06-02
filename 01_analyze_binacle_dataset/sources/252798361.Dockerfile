FROM php:7.1-alpine  
  
RUN apk add --no-cache wget  
  
COPY . /app  
RUN wget https://getcomposer.org/composer.phar \  
&& php composer.phar -d=/app install --no-dev --no-interaction \  
&& rm composer.phar  
WORKDIR /app  
  
CMD [ "php", "./backup.php" ]  

