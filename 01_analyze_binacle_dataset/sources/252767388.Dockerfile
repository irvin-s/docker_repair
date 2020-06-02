FROM nginx:alpine  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY nginx-default.conf /etc/nginx/conf.d/default.conf  

