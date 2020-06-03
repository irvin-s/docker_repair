FROM ubuntu  
  
RUN apt-get update && \  
apt-get dist-upgrade -y && \  
apt-get install -y nginx-extras ca-certificates gettext-base && \  
rm -rf /var/cache/apt && rm -rf /var/lib/apt  
  
EXPOSE 80  
VOLUME /var/www/html  
CMD nginx -g 'daemon off;'  

