FROM nginx:1  
MAINTAINER aria@fallah.us  
  
COPY nginx.conf mime.types /etc/nginx/  
COPY h5bp /etc/nginx/h5bp  
  
RUN mkdir /etc/nginx/logs \  
&& touch /etc/nginx/logs/access.log /etc/nginx/logs/error.log  

