FROM confluent/platform  
  
EXPOSE 2181 2888 3888  
CMD ["/usr/bin/zookeeper-server-start", "/etc/kafka/zookeeper.properties"]

