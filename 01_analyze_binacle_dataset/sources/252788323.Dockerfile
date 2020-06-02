FROM debian  
  
RUN apt-get update && apt-get install -y minidlna vim net-tools  
  
COPY files/start.sh /opt/start.sh  
RUN chmod 755 /opt/start.sh  
  
ENTRYPOINT /opt/start.sh  

