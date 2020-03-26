FROM docker.elastic.co/elasticsearch/elasticsearch:6.5.4

RUN bin/elasticsearch-plugin install --batch ingest-attachment