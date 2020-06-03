FROM nginx:alpine  
  
MAINTAINER Ben Reichert  
  
RUN echo "daemon off;" >> /etc/nginx/nginx.conf  
  
COPY default.conf /etc/nginx/conf.d/default.conf  
  
ENTRYPOINT ["nginx"]  

