FROM node:6  
MAINTAINER Adrian Perez <adrian@adrianperez.org>  
  
RUN npm -g install browser-sync  
WORKDIR /source  
  
ADD entrypoint.sh /entrypoint.sh  
EXPOSE 3000 3001  
ENTRYPOINT ["/entrypoint.sh"]  

