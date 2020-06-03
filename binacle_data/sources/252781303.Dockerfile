FROM logstash:5.5.2-alpine  
  
RUN rm -f /usr/share/logstash/pipeline/logstash.conf  
  
ADD config/ /usr/share/logstash/pipeline/  
  
CMD ["-f", "/usr/share/logstash/pipeline/10-coyo.conf"]  

