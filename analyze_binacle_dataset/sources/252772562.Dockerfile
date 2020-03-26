FROM logstash:5.2.2-alpine  
  
MAINTAINER Benjah1 <benjaminhuang1@gmail.com>  
  
USER logstash  
  
COPY . /app/logstash  

