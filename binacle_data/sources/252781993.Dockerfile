FROM nginx:1.13.5  
RUN apt-get update && apt-get install -y certbot cron  
COPY scripts/init.sh /opt/init.sh  
RUN chmod +x /opt/init.sh  
  
EXPOSE 80 443 8080 8443  
VOLUME ["/var/www/html"]  
VOLUME ["/etc/letsencrypt"]  
VOLUME ["/etc/nginx"]  
  
EXPOSE 80 443 8000 8001 8080 8443  
STOPSIGNAL SIGTERM  
  
ENTRYPOINT ["/opt/init.sh"]  

