FROM nginx:alpine  
  
ONBUILD COPY . /usr/share/nginx/html/  

