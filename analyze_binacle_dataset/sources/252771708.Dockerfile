FROM logstash:2.4.0  
ADD logstash.conf /etc/logstash/conf.d/logstash.conf  
  
CMD ["logstash", "-f", "/etc/logstash/conf.d/logstash.conf","-w","4"]  

