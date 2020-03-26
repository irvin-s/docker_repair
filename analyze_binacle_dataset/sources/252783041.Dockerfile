FROM nginx:alpine  
  
  
RUN set -x \  
&& addgroup -g 991 -S www-data \  
&& adduser -u 991 -D -S -G www-data www-data  

