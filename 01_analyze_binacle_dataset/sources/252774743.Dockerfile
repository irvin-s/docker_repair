FROM nginx:latest  
  
VOLUME /usr/local/etc/php/php.ini  
  
COPY nginx.conf /etc/nginx/conf.d/default.conf  
  

