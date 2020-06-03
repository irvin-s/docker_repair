FROM elasticsearch:5.5.2-alpine  
  
COPY ./elasticsearch.yml "/usr/share/elasticsearch/config/elasticsearch.yml"

