FROM clevertodayinc/clever-nginx  
MAINTAINER Brice Argenson <brice@clevertoday.com>  
  
COPY docker-entrypoint.sh /entrypoint.sh  
  
COPY html /usr/share/nginx/html  
COPY tls /etc/nginx/tls  
COPY config/nginx.conf /etc/nginx/nginx.conf.template  
  
EXPOSE 80 443  
ENTRYPOINT ["/entrypoint.sh"]  

