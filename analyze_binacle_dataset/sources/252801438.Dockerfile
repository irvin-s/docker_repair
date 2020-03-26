FROM nginx:alpine  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY sites-enabled /etc/nginx/sites-enabled  

