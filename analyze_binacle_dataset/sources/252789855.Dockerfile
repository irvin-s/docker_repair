FROM nginx:1.11.5-alpine  
  
VOLUME /www  
VOLUME /ssl  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY config/* /etc/nginx/conf.d/  

