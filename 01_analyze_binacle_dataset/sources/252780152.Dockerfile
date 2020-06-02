FROM nginx:stable-alpine  
  
MAINTAINER Contextualist <harzjc@gmail.com>  
  
COPY nginx.conf /etc/nginx/nginx.conf  
WORKDIR /usr/src/app  
COPY ["index.php", "base64.js", "./"]  
  
EXPOSE 80  

