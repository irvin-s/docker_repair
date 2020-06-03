FROM nginx  
  
MAINTAINER Dries De Peuter <dries@nousefreak.be>  
  
RUN rm /etc/nginx/conf.d/*  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY nginx-default.conf /etc/nginx/conf.d/default.conf  

