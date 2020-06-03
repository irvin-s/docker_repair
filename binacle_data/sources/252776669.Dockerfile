FROM nginx:alpine  
  
COPY default.conf /etc/nginx/conf.d/default.conf  
  
ADD app /usr/share/nginx/html/  

