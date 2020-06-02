FROM docker.elastic.co/logstash/logstash-oss:6.2.2  
ENV ELASTICSEARCH onyx.dynu.com  
RUN rm -f /usr/share/logstash/pipeline/logstash.conf  
ADD pipeline/ /usr/share/logstash/pipeline/  
ADD config/ /usr/share/logstash/config/  

