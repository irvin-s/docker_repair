FROM jwilder/nginx-proxy:alpine  
LABEL maintainer="stefano@dragas.it"  
RUN { \  
echo 'client_max_body_size 0;'; \  
} > /etc/nginx/conf.d/unrestricted_client_body_size.conf  

