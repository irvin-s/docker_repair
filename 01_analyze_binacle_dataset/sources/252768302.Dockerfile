FROM ubuntu:16.04  
RUN apt-get update && \  
apt-get -y install curl jq && \  
apt-get clean -q  
  
ENV SERVICE_CLUSTER_NAME ""  
ENV SERVICE_ELASTICSEARCH_HOST elasticsearch  
ENV SERVICE_ELASTICSEARCH_PORT 9200  
ENV SERVICE_ELASTICSEARCH_USERNAME ""  
ENV SERVICE_ELASTICSEARCH_PASSWORD ""  
ADD startup.sh /usr/bin/startup.sh  
  
CMD ["/usr/bin/startup.sh"]  

