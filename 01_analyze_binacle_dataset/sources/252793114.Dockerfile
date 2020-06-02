FROM node:latest  
  
RUN set -x; \  
mkdir /project; \  
mkdir /var/www; \  
\  
chown -R www-data:www-data /project; \  
chown -R www-data:www-data /var/www; \  
\  
chmod -R 2775 /project; \  
chmod -R 2775 /var/www;  
  
WORKDIR /project  

