FROM nginx:1.13.1-alpine  
  
COPY /nginx.conf /etc/nginx/nginx.conf  
COPY html /usr/share/nginx/html  
  
RUN mkdir /ssl  
VOLUME /ssl  
  
EXPOSE 80  
EXPOSE 443

