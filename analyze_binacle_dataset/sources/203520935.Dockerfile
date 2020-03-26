FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.4.1

COPY elasticsearch.yml /usr/share/elasticsearch/config/