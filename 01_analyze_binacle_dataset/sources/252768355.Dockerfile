FROM ubuntu  
  
ENV DOCK_MESSAGE Hello My World  
ENV DOCK_LOG_FILE_NAME output.txt  
ENV DOCK_PORT 8080  
RUN apt-get update && apt-get -y install netcat  
ADD scripts /scripts  
  
VOLUME ["/log"]  
  
EXPOSE $DOCK_PORT  
  
WORKDIR /scripts  
CMD ["bash", "/scripts/echo-server.sh"]  

