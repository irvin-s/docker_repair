FROM nginx:1.13.1-alpine  
COPY src/index.html /usr/share/nginx/html/  
COPY src/css /usr/share/nginx/html/css/  
COPY src/img /usr/share/nginx/html/img/  
COPY default.conf /etc/nginx/conf.d/default.conf  

