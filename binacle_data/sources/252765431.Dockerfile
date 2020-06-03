FROM ghost  
  
MAINTAINER Imran Ismail <imran@127labs.com>  
  
ENV THEME_NAME 127labs  
  
COPY config.js /usr/src/ghost/  
COPY src /usr/src/ghost/content/themes/$THEME_NAME  
COPY docker-entrypoint.sh /entrypoint.sh  

