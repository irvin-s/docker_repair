FROM python:2.7  
  
ENV SERVICE_CURATOR_LOGGING_LEVEL=INFO \  
SERVICE_CURATOR_LOGGING_FORMAT=default \  
SERVICE_ELASTICSEARCH_HOST=elasticsearch \  
SERVICE_ELASTICSEARCH_PORT=9200 \  
SERVICE_ELASTICSEARCH_USERNAME="" \  
SERVICE_ELASTICSEARCH_PASSWORD=""  
RUN apt-get update -q && \  
apt-get install -qy cron && \  
apt-get clean -q && \  
pip install elasticsearch-curator==5.4.1  
  
RUN mkdir -p /scripts /config/actions  
  
ADD scripts/run_curator.sh /scripts/run_curator.sh  
ADD config/curator.yaml /config  
ADD run.sh /run.sh  
  
CMD ["/run.sh"]  

