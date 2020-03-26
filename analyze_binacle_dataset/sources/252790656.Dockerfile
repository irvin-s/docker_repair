FROM carpenike/baseimage-python27  
MAINTAINER carpenike <carpenike@gmail.com>  
  
# add local files  
COPY root/ /  
  
# ports and volumes  
VOLUME /config /logs  
EXPOSE 8181  

