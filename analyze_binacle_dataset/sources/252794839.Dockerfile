FROM nginx:alpine  
  
COPY default.conf /etc/nginx/conf.d/  
  
EXPOSE 80  

