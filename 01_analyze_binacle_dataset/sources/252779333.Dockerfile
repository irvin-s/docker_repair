FROM alpine  
RUN apk --update add openssl curl certbot nginx supervisor && \  
mkdir -p /etc/letsencrypt/configs/ && \  
mkdir -p /var/www/letsencrypt && \  
mkdir -p /run/nginx && \  
mkdir -p /var/log/supervisord && \  
chgrp -R www-data /var/www/letsencrypt && \  
echo "daemon off;" >> /etc/nginx/nginx.conf  
COPY nginx.default.conf /etc/nginx/conf.d/default.conf  
COPY renew_all.sh /etc/periodic/weekly/  
COPY supervisord.conf /etc/supervisord.conf  
RUN chmod +x /etc/periodic/weekly/renew_all.sh  
EXPOSE 80 9001  
ENTRYPOINT [ "supervisord", "-n" ]  

