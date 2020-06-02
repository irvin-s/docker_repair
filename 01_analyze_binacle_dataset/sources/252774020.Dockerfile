FROM logstash:5.2.1  
ADD logstash.conf /etc/logstash/logstash.conf  
  
CMD logstash -f /etc/logstash/logstash.conf

