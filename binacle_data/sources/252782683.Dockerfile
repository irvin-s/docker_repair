FROM nginx:1.10  
MAINTAINER Brice Argenson <brice@clevertoday.com>  
  
COPY docker-entrypoint.sh /  
  
COPY html /usr/share/nginx/html  
COPY tls /etc/nginx/tls  
COPY config/nginx.conf /etc/nginx/nginx.conf  
  
EXPOSE 80 443  
ENTRYPOINT ["/docker-entrypoint.sh"]  

