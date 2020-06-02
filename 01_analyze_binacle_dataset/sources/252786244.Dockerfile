FROM nginx:alpine  
  
MAINTAINER DMSi Software  
  
WORKDIR /etc/nginx  
ADD nginx.conf /etc/nginx/nginx.conf  
  
EXPOSE 80

