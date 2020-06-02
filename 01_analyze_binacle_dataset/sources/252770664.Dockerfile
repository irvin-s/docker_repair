FROM nginx:alpine  
MAINTAINER Aexea Carpentry  
  
RUN mkdir -p /etc/nginx/sites-enabled  
  
VOLUME /etc/nginx/sites-enabled  
VOLUME /var/log/nginx  
  
COPY nginx.conf /etc/nginx/nginx.conf  
  
EXPOSE 80 443 9999  

