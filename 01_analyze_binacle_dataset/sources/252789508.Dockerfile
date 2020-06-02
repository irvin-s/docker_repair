FROM nginx:latest  
  
MAINTAINER Alexander Dunin <a@dunin.by>  
  
COPY ./conf/nginx.conf /etc/nginx/nginx.conf  
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf  

