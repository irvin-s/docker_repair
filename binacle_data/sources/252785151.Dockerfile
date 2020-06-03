# Do not use nginx as base since extras are not included.  
FROM debian:stretch  
  
RUN apt-get update && apt-get upgrade -y && \  
apt-get install -y nginx nginx-extras apache2-utils && \  
rm -rf /var/lib/apt/lists/* && \  
rm /etc/nginx/sites-enabled/default && \  
ln -sf /dev/stdout /var/log/nginx/access.log && \  
ln -sf /dev/stderr /var/log/nginx/error.log && \  
mkdir -p /var/www/.temp && \  
chown -R www-data:www-data /var/www && \  
chmod -R a+rw /var/www  
  
COPY set_htpasswd.sh /set_htpasswd.sh  
COPY webdav-site.conf /etc/nginx/sites-enabled/  
# Overwrite mimetypes to add rss format.  
COPY mime.types /etc/nginx/  
  
# Share the volume with the files to other dockers  
VOLUME /var/www  
  
EXPOSE 80  
CMD /set_htpasswd.sh && nginx -g "daemon off;"  

