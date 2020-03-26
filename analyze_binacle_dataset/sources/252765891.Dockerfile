FROM logstash:5.2.1  
MAINTAINER caiwb  
  
RUN logstash-plugin install logstash-output-jdbc  

