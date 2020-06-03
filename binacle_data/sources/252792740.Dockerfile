FROM scratch  
MAINTAINER daniel.guerra69@gmail.com  
ADD usr/share/elasticsearch/data /usr/share/elasticsearch/data  
VOLUME /usr/share/elasticsearch/data  

