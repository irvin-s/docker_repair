FROM ubuntu:latest  
  
MAINTAINER Cyril  
  
COPY heartbeat.sh /entrypoint.sh  
  
RUN chmod +x entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["default"]

