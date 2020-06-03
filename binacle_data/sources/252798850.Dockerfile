FROM elasticsearch:5.1.2  
RUN bin/elasticsearch-plugin install ingest-attachment  

