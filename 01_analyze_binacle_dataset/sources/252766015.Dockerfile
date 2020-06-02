FROM docker.elastic.co/logstash/logstash:6.2.3  
LABEL MAINTAINER Greg Feigenson <kog@epiphanic.org>  
  
ENV LOGSTASH_HOME=/usr/share/logstash  
  
# Copy our logstash configs.  
COPY app/logstash/logstash.conf ${LOGSTASH_HOME}/pipeline/logstash.conf  
COPY app/logstash/jetty-request-template.json ${LOGSTASH_HOME}/  
COPY app/logstash/logstash.yml ${LOGSTASH_HOME}/config/logstash.yml  
  
# Copy our dashboard components.  
COPY /app/kibana-goodies ${LOGSTASH_HOME}/kibana-goodies  
  
ENTRYPOINT ["kibana-goodies/load.sh"]

