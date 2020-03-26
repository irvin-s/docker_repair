FROM nginx:1.12  
MAINTAINER cake17 <cake17@cake-websites.com>  
  
RUN rm /etc/nginx/conf.d/default.conf  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY conf.d/gandi.conf /etc/nginx/conf.d/gandi.conf  
  
RUN usermod -u 1000 www-data  

