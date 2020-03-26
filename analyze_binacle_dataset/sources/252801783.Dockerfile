FROM logstash:5.6.8  
RUN logstash-plugin install logstash-filter-de_dot  
  
CMD ["-f", "/usr/share/logstash/config/logstash.yml"]  

