# Elasticsearch with Marvel (monitoring tool)
# Open:
# http://localhost:9200/_plugin/marvel/
FROM barnybug/elasticsearch
MAINTAINER Barnaby Gray <barnaby@pickle.me.uk>

RUN elasticsearch-1.1.0/bin/plugin -i elasticsearch/marvel/latest
