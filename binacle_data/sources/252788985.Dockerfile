FROM nginx  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY default.conf /etc/nginx/conf.d/default.conf  
  
WORKDIR /var/www/html  
VOLUME /var/www/html  
  
EXPOSE 80  

