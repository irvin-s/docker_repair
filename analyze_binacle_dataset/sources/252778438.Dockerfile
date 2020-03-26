FROM jwilder/nginx-proxy  
LABEL maintainer="dylan@arcadiandigital.com.au"  
RUN { \  
echo 'server_tokens off;'; \  
echo 'client_max_body_size 100m;'; \  
echo 'fastcgi_read_timeout 600;'; \  
echo 'proxy_read_timeout 600;'; \  
} > /etc/nginx/conf.d/my_proxy.conf  
  
HEALTHCHECK \--interval=1m --timeout=30s --start-period=5s --retries=3 \  
CMD nginx -t || exit 1  

