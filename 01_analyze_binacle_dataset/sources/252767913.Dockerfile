FROM busybox  
  
ADD elasticsearch-default-config.yml /etc/elasticsearch/elasticsearch.yml  
ADD logging-default-config.yml /etc/elasticsearch/logging.yml  
ADD logstash.conf /etc/opt/logstash/logstash.conf  
  
VOLUME /etc/elasticsearch  
VOLUME /etc/opt/logstash  
  
CMD ["true"]  

