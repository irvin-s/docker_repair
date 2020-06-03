FROM jwilder/nginx-proxy:latest  
RUN { \  
echo 'client_max_body_size 24m;'; \  
} > /etc/nginx/conf.d/custom.conf

