FROM busybox  
  
ADD nginx/conf.d/ /etc/nginx/conf.d/  
ADD nginx/vhost.d/ /etc/nginx/vhost.d/  
ADD nginx/templates/ /etc/docker-gen/templates/  
ADD nginx/wwwroot/ /usr/share/nginx/html/  
  
VOLUME /etc/nginx/conf.d  
VOLUME /etc/nginx/vhost.d  
VOLUME /etc/docker-gen/templates  
VOLUME /usr/share/nginx/html  

