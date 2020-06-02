FROM node:10.3-alpine  
  
RUN addgroup -g 82 www-data \  
&& adduser -u 82 -G www-data -s /sbin/nologin -D www-data \  
&& mkdir -p /app \  
&& chown www-data:www-data /app  
  
USER www-data:www-data  
  
WORKDIR /app  

