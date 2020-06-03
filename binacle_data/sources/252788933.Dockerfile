FROM jwilder/nginx-proxy  
  
ADD nginx.conf /etc/nginx/nginx.conf  
  
EXPOSE 443

