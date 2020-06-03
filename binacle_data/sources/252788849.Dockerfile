FROM logstash:2.3  
COPY logstash.conf /conf/logstash.conf  
COPY start_logstash.sh /  
  
EXPOSE 5000/udp  
EXPOSE 12201/udp  
  
CMD ["/start_logstash.sh"]  

