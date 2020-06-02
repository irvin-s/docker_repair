FROM docker.elastic.co/logstash/logstash-oss:6.2.1  
RUN logstash-plugin install logstash-output-amazon_es  
RUN logstash-plugin install logstash-filter-mutate  
RUN logstash-plugin install logstash-filter-date  
RUN logstash-plugin install logstash-filter-json_encode  
  
ADD template/ /usr/share/logstash/template/  
ADD config/ /usr/share/logstash/config/  
RUN rm -f /usr/share/logstash/pipeline/logstash.conf  
ADD pipeline/ /usr/share/logstash/pipeline/

