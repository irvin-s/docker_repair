FROM docker.elastic.co/logstash/logstash:5.4.1  
# Add your logstash plugins setup here  
# Example: RUN logstash-plugin install logstash-filter-json  
ADD config/logstash.yml /usr/share/logstash/config/  
ADD pipeline/logstash.conf /usr/share/logstash/pipeline/  
  
CMD ["logstash", "-f", "/usr/share/logstash/pipeline/logstash.conf"]  

