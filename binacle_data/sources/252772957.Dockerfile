FROM nginx:alpine  
  
COPY fastcgi.conf /etc/nginx/  
COPY ssl_config.conf /etc/nginx/  
COPY gzip.conf /etc/nginx/  
  
VOLUME /etc/nginx/conf.d  
  
VOLUME /etc/letsencrypt  
  
WORKDIR /var/www  

