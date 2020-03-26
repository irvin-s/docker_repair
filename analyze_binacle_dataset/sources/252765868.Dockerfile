FROM php:7.2.5-cli-alpine3.7  
RUN mkdir /app  
  
ADD vendor /app/vendor  
ADD index.php /app/index.php  
ADD src /app/src  
  
WORKDIR /app  
  
ENTRYPOINT ["php", "index.php"]

