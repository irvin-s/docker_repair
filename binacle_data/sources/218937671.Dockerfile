FROM icclabcna/zurmo_logstash_forwarder
  
# ADD forwarder_config.json /etc/logstash-forwarder.conf
ADD logstash_forwarder.toml /etc/confd/conf.d/logstash_forwarder.toml
ADD logstash_forwarder.json.tmpl /etc/confd/templates/logstash_forwarder.json.tmpl

