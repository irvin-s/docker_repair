FROM spotify/kafka  
  
RUN apt-get update && \  
apt-get -y install patch  
  
COPY server.properties.patch /tmp/  
  
RUN patch -d $KAFKA_HOME/config -p0 -u < /tmp/server.properties.patch && \  
rm -f /tmp/server.properties.patch  
  
WORKDIR $KAFKA_HOME  

