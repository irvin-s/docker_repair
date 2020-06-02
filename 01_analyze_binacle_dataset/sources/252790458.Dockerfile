FROM nginx:stable-alpine  
  
COPY ./dist/prod/ /usr/share/nginx/html/  

