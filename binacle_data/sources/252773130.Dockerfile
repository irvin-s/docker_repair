FROM nginx:1.13.10-alpine  
  
VOLUME ["/srv/www"]  
  
RUN rm /etc/nginx/conf.d/default.conf  
COPY etc/nginx.conf /etc/nginx/nginx.conf  
COPY etc/app.conf /etc/nginx/conf.d/  

