FROM nginx:latest  
LABEL MAINTAINER Sebastian Elisa Pfeifer <sebastian.pfeifer@unicorncloud.org>  
  
COPY ./web /usr/share/nginx/html  
  
EXPOSE 80  

