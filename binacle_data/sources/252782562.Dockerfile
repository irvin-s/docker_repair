FROM clastic/nginx  
  
MAINTAINER Dries De Peuter <dries@nousefreak.be>  
  
COPY nginx-default.conf /etc/nginx/conf.d/default.conf  

