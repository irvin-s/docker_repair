FROM bonelli/spark-standalone  
  
EXPOSE 7077 8080  
ADD run-master.sh /opt/  
  
WORKDIR /opt/spark-1.1.0-bin-hadoop2.4  
CMD /opt/run-master.sh  

