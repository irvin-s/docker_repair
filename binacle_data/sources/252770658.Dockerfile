FROM nginx:alpine  
MAINTAINER Aexea Carpentry  
  
COPY HQ /usr/share/nginx/html/HQ/  
COPY head /usr/share/nginx/html/head/  
COPY kibana /usr/share/nginx/html/kibana/  
COPY index.html /usr/share/nginx/html/  
COPY default.conf /etc/nginx/conf.d/  

