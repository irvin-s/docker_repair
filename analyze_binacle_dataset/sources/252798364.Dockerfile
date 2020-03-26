FROM php:7.1-alpine  
  
COPY . /app  
RUN apk add --no-cache wget \  
&& wget https://getcomposer.org/composer.phar \  
&& php composer.phar --working-dir=/app install --no-dev --no-interaction \  
&& rm composer.phar \  
&& apk del wget  
  
WORKDIR /app  
  
CMD [ "php", "./migrate.php" ]  

