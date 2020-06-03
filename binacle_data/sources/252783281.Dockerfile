FROM nginx:1.9.6  
COPY files /usr/share/nginx/html  
COPY nginx.conf /etc/nginx/nginx.conf  
  

