FROM sebp/elk

# copy logstash grok pattern
ADD ./app-log.pattern ${LOGSTASH_HOME}/patterns/app-log

# copy logstash beats-input key and certificate
ADD ./logstash-beats.crt /etc/pki/tls/certs/logstash-beats.crt
ADD ./logstash-beats.key /etc/pki/tls/private/logstash-beats.key

# overwrite logstash config files
ADD ./02-beats-input.conf /etc/logstash/conf.d/02-beats-input.conf
ADD ./30-output.conf /etc/logstash/conf.d/30-output.conf

# add custom elastic search index template for filebeat entries
ADD  ./vertx_app_filebeat.json /etc/filebeat/vertx_app_filebeat.json