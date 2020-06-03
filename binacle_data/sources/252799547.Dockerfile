FROM logstash:latest  
  
COPY logstash.conf /opt/  
  
CMD ["-f", "/opt/logstash.conf"]  

