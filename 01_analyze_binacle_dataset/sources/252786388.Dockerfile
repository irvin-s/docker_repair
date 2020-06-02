FROM dockenizer/alpine  
MAINTAINER Jacques Moati <jacques@moati.net>  
  
RUN apk --update add nginx && \  
  
ln -sf /dev/stdout /var/log/nginx/access.log && \  
ln -sf /dev/stderr /var/log/nginx/error.log && \  
mkdir /etc/nginx/sites-enabled/ && \  
mkdir -p /etc/letsencrypt/webrootauth && \  
rm -rf /var/www/* && \  
touch /var/www/favicon.ico && \  
  
rm -rf /var/cache/apk/*  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY default.conf /etc/nginx/sites-enabled/default.conf  
COPY index.html /var/www/index.html  
  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]  
  

