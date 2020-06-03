FROM docker.elastic.co/beats/metricbeat:6.4.1
WORKDIR /usr/share/metricbeat/
COPY dashboards/ ./
COPY wait-for-elasticsearch.sh set-logs-index-pattern-as-default.sh ./
ENV ELASTICSEARCH_URL=http://jhipster-elasticsearch:9200
ENV KIBANA_URL=http://jhipster-console:5601

CMD ./wait-for-elasticsearch.sh \
    && ./metricbeat setup --dashboards \
        -E output.elasticsearch.hosts="[$ELASTICSEARCH_URL]" \
        -E setup.kibana.host=$KIBANA_URL \
        -E setup.dashboards.directory=/usr/share/metricbeat/import \
    && ./set-logs-index-pattern-as-default.sh