# Set nginx base image  
FROM nginx  
  
# File Author / Maintainer  
MAINTAINER Adrián García Espinosa "adri@syncrtc.com"  
# Copy custom configuration file from the current directory  
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf  
COPY ./app/build/bundled /www/app  
  
VOLUME /www/app  

