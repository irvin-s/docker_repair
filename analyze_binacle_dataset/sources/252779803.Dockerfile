FROM java:8  
MAINTAINER kim@conduct.no  
  
EXPOSE 8080  
ADD run.sh /opt/run.sh  
VOLUME ["/opt/repo"]  
  
CMD ["/opt/run.sh"]  

