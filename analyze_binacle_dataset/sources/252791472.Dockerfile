FROM nginx:alpine  
RUN addgroup -g 1000 -S www-data \  
&& adduser -u 1000 -D -S -G www-data www-data  
ADD nginx.conf /etc/nginx/nginx.conf

