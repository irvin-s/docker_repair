FROM php:7.0-alpine  
COPY . /app  
VOLUME /app  
EXPOSE 3000  
WORKDIR /app  
CMD ["php", "-S", "0.0.0.0:3000", "-t", "/app"]  

