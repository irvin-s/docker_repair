FROM logstash

# add custom config
COPY logstash-json-docker.conf /config/logstash-json-docker.conf

# add templates
COPY ./templates/ /config/templates/
