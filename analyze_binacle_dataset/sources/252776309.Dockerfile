FROM bonelli/spark-standalone  
  
EXPOSE 7078 8081  
ADD run-slave.sh /opt/  
  
WORKDIR /opt/spark-1.1.0-bin-hadoop2.4  
CMD /opt/run-slave.sh  

