FROM java:8-jre  
MAINTAINER Aexea Carpentry  
  
# Download version 2.3.2 of logstash  
RUN cd /tmp && \  
wget https://download.elastic.co/logstash/logstash/logstash-2.3.2.tar.gz && \  
tar -xzvf ./logstash-2.3.2.tar.gz && \  
mv ./logstash-2.3.2 /opt/logstash && \  
rm ./logstash-2.3.2.tar.gz  
  
WORKDIR /opt/logstash  
RUN bin/logstash-plugin install logstash-input-udp  
RUN bin/logstash-plugin install logstash-input-syslog  
RUN bin/logstash-plugin install logstash-filter-json  
RUN bin/logstash-plugin install logstash-output-elasticsearch  
RUN bin/logstash-plugin install logstash-output-amazon_es  
  
RUN mkdir -p /conf  
ADD default.conf /conf/default.conf  
  
VOLUME /conf  
  
EXPOSE 5959/UDP  
  
CMD bin/logstash -f /conf  

