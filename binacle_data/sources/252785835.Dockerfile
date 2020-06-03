FROM jwilder/nginx-proxy  
  
COPY certs /etc/nginx/certs  
COPY app/ /app/  
  
ENV DEFAULT_HOST=divio.me  

