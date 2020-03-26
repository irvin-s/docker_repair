FROM nginx:1.13  
  
COPY ./etc/nginx/default.conf /etc/nginx/conf.d/default.conf  
  
COPY ./html /usr/share/nginx/html  

