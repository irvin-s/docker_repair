FROM nginx:alpine  
  
COPY default.conf /etc/nginx/conf.d/default.conf  
  
ADD src /usr/share/nginx/html/  

