FROM nginx:latest  
MAINTAINER Dobedobedo  
  
RUN apt-get update && apt-get -y install \  
python-certbot-nginx \  
cron \  
&& rm -rf /var/lib/apt/lists/*  
  
# Schedule Let's encrypt renewal  
COPY ./certbot-renew /etc/cron.daily/  
RUN chmod +x /etc/cron.daily/certbot-renew  
  
# Remove default certbot script  
RUN rm -f /etc/cron.d/certbot  
  
VOLUME /etc/nginx/conf.d  
VOLUME /usr/share/nginx/html  
VOLUME /etc/letsencrypt/  
  
STOPSIGNAL SIGTERM  
  
COPY ./entrypoint.sh /  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  

