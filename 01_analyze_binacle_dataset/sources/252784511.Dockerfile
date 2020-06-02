FROM nginx:stable-alpine  
  
RUN apk add --no-cache apache2-utils  
  
ADD nginx.conf.template /files/nginx.conf.template  
  
ADD start.sh /start.sh  
RUN chmod +x /start.sh  
  
ENTRYPOINT ["/bin/sh", "/start.sh"]

