FROM chauffer/nginx-for-rancher  
  
COPY www/ /var/www  
COPY simone.conf /etc/nginx/conf.d/default.conf  

