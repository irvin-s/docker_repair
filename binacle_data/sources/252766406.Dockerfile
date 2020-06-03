FROM lsiobase/alpine.python  
MAINTAINER abriemme  
  
# add local files  
COPY root/ /  
  
# ports and volumes  
VOLUME /config /logs  
EXPOSE 8181  

