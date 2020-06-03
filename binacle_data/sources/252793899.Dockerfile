FROM ubuntu:14.04  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get -y upgrade && \  
apt-get install -y zookeeper && \  
apt-get clean  
  
EXPOSE 2888 3888 2181  
  
ENTRYPOINT /usr/share/zookeeper/bin/zkServer.sh start-foreground  

