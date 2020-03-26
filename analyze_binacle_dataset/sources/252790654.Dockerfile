FROM logstash:5  
RUN logstash-plugin install logstash-filter-multiline  
  
CMD ["-f", "/config/logstash.conf"]  

