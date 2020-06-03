FROM confluent/platform  
  
EXPOSE 9092  
ADD server.properties /etc/kafka/server.properties  
  
CMD ["/usr/bin/kafka-server-start", "/etc/kafka/server.properties"]

