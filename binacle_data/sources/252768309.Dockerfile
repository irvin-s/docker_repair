FROM ubuntu:16.04  
RUN apt-get update && \  
apt-get -y install curl jq && \  
apt-get clean -q  
  
ENV SERVICE_KAFKA_MANAGER_HOST kafka-manager  
ENV SERVICE_KAFKA_MANAGER_PORT 9000  
ADD startup.sh /usr/bin/startup.sh  
  
CMD ["/usr/bin/startup.sh"]  

