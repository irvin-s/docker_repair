FROM nginx  
  
COPY base.conf /etc/nginx/conf.d/  
COPY server.conf /etc/nginx/conf.d/  
  
RUN mkdir -p /var/www/static  

