FROM docker.elastic.co/logstash/logstash:5.5.0  
MAINTAINER chaya  
  
#COPY ./conf/logstash.yml /usr/share/logstash/config/logstash.yml  
COPY ./pipeline/logstash.conf /usr/share/logstash/pipeline/logstash.conf

