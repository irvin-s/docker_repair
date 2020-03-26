FROM nginx:stable  
  
ADD index.html /usr/share/nginx/html  
ADD nginx.conf /etc/nginx/nginx.conf  

