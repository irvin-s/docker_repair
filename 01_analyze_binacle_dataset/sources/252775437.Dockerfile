FROM nginx:alpine  
ADD html /usr/share/nginx/html  
EXPOSE 80 443  

