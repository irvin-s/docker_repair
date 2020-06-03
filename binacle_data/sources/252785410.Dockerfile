FROM logstash:2.0.0-1  
MAINTAINER Matt Kimber <matt.kimber@collinsongroup.com>  
  
COPY src /configScripts  
COPY config /etc/exchanges  
  
RUN chmod +x /configScripts/start.sh \  
&& mkdir -p /etc/logstash/conf.d/ \  
&& cd /configScripts \  
&& apt-get update \  
&& apt-get install -y python-pip \  
&& pip install -r requirements.txt \  
&& apt-get remove -y python-pip \  
&& apt-get clean  
  
ENV RABBIT_HOST=localhost  
ENV RABBIT_PORT=5672  
ENV RABBIT_EXCHANGE=client_operations  
ENV RABBIT_QUEUE=logstash  
ENV RABBIT_USERNAME=guest  
ENV RABBIT_PASSWORD=guest  
ENV ELASTICSEARCH_HOST=elasticsearch  
ENV ELASTICSEARCH_PORT=9200  
  
ENTRYPOINT ["/configScripts/start.sh"]  
CMD ["logstash", "agent", "-f /etc/logstash/conf.d/logstash.conf"]  

