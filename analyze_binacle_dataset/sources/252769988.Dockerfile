FROM logstash:2  
MAINTAINER Arthur Pham <arthur.pham@gmail.com>  
LABEL Description=""  
  
COPY scrapy-cluster-logstash-docker.conf /etc/logstash/conf.d/logstash.conf  
COPY logs-template.json /etc/logstash/templates/logs-template.json  
  
CMD logstash -f /etc/logstash/conf.d/logstash.conf  

