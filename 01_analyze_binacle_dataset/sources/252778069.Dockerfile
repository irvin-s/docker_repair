FROM python:3.4.4  
MAINTAINER quint@appeine.com  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV TZ UTC  
  
# Installing Mongo Connector which will connect MongoDB and Elasticsearch  
# We're using a fork of elastic-doc-manager that support multiple  
# Elastic hosts.  
RUN pip install --upgrade pip && pip install\  
mongo-connector==2.4\  
https://github.com/quintstoffers/elastic-doc-manager/archive/master.zip  
  
ENTRYPOINT ["mongo-connector","-d","elastic_doc_manager","--stdout"]  

