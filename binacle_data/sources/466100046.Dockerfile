FROM docker.elastic.co/elasticsearch/elasticsearch-platinum:6.1.4

RUN printf "y/n" | bin/elasticsearch-plugin install ingest-attachment
