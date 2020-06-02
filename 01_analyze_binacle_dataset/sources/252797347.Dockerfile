FROM redis:latest  
MAINTAINER Christian Lück <christian@lueck.tv>  
  
ADD run.sh /run.sh  
ENTRYPOINT ["/run.sh"]  
CMD []  

