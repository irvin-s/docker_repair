FROM nginx:alpine  
COPY html /usr/share/nginx/html  
COPY site.conf /etc/nginx/conf.d/site.conf  

