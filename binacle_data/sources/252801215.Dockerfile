FROM nicolargo/glances:latest  
MAINTAINER @adrien-f <adrien.fillon@gmail.com>  
  
VOLUME /config  
EXPOSE 61208/tcp  
  
CMD python -m glances $GLANCES_ARGS  

