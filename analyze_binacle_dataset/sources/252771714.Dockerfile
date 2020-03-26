FROM jwilder/nginx-proxy:alpine  
  
# Default health check url  
ENV HEALTH_CHECK_URL "/api/v[0-9]+/health-?check$"  
COPY default_location /etc/nginx/vhost.d/  
COPY run_nginx.sh /app/run_nginx.sh  
  
CMD ["/app/run_nginx.sh"]  
  
EXPOSE 80

