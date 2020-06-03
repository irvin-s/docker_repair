FROM elasticsearch:2.2
WORKDIR /usr/share/elasticsearch
RUN bin/plugin install cloud-aws
RUN bin/plugin install mobz/elasticsearch-head

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY config/elasticsearch /etc/default/elasticsearch

VOLUME /usr/share/elasticsearch/data

EXPOSE 9200 9300
