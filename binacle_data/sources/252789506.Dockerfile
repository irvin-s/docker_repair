FROM nginx:1.13.3-alpine  
  
MAINTAINER Alexander Dunin <a@dunin.by>  
  
COPY ./conf/nginx.conf /etc/nginx/nginx.conf  
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf  

