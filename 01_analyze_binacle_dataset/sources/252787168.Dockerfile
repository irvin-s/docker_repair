FROM ghost:0.5.10  
MAINTAINER Andres Rojas <andres@conpat.io>  
ENV REFRESHED_AT 2015-04-15  
  
COPY config/config.js /var/lib/ghost/config.js  

