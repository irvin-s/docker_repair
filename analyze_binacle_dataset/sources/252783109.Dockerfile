FROM php:7.0-cli  
  
COPY config content public src /opt/site/  
  
WORKDIR /opt/site  
  
CMD [ "php", "-S localhost:80" ]  

