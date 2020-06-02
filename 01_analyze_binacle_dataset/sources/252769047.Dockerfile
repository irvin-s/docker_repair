FROM anduin/confluent-base:1.0  
MAINTAINER ductamnguyen@anduintransact.com  
  
ADD ./configs /opt/configs  
RUN mkdir -p /etc/service/zookeeper  
ADD ./services/run-zookeeper.sh /etc/service/zookeeper/run  
RUN chmod +x /etc/service/zookeeper/run  
  
RUN mkdir -p /etc/service/kafka  
ADD ./services/run-kafka.sh /etc/service/kafka/run  
RUN chmod +x /etc/service/kafka/run  
  
VOLUME /data  
  
CMD ["/sbin/my_init"]  

