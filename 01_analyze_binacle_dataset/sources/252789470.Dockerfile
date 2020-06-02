FROM solr:6.6.0-alpine  
  
COPY config /config  
COPY solr-create /opt/docker-solr/scripts  
USER root  
RUN chmod +x /opt/docker-solr/scripts/solr-create  
USER solr  
  
RUN solr-create -c medspace -d /config

