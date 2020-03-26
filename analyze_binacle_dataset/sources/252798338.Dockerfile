FROM nginx:1.7.7  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY upgrademessage.html /www/index.html

