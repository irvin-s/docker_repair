FROM logstash:2.1.1-1  
MAINTAINER Quirino Brizi, <quirino.brizi@accenture.com>  
  
ADD ./resources/config/logstash.yml /etc/logstash/conf.d/logstash.yml  
  
CMD logstash -f /etc/logstash/conf.d/logstash.yml

