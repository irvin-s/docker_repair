FROM alpine  
  
COPY ./dist/. /usr/src/front-end/  
# VOLUME ['/usr/src/app', 'usr/src/app/static']  
CMD ping www.google.com

