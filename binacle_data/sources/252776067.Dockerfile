FROM docker  
ADD yaml-parser.sh /commands/yaml-parser.sh  
ADD run.sh /commands/run.sh  
WORKDIR /commands  
VOLUME /data  
VOLUME /config  
CMD ["/bin/sh", "run.sh"]  

