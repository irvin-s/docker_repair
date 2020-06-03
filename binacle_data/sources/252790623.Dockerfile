FROM nginx:stable-alpine  
  
MAINTAINER Carl Skeide "carl@skeide.se"  
  
RUN mkdir -p /srv/www /srv/static /srv/media  
  
COPY nginx.server.conf /etc/nginx/conf.d/default.conf  
  
COPY nginx.locations.conf /etc/nginx/location.d/default.conf;  

