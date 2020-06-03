FROM docker.elastic.co/elasticsearch/elasticsearch:5.5.0

COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
