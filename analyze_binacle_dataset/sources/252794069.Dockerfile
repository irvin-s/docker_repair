FROM jwilder/nginx-proxy  
RUN { \  
echo 'real_ip_header X-Forwarded-For;'; \  
echo 'set_real_ip_from 0.0.0.0/0;'; \  
} > /etc/nginx/conf.d/elb_proxy.conf  
  

