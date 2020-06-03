FROM jwilder/nginx-proxy  
MAINTAINER Chuck Conway charles@cconway.com  
RUN { \  
echo 'client_max_body_size 100m;'; \  
} > /etc/nginx/conf.d/my_proxy.conf  

