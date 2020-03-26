FROM rounds/10m-logstash-forwarder
MAINTAINER Ofir Petrushka ROUNDS <ofir@rounds.com>

# Config config files
COPY etc/logstash-forwarder/* /etc/logstash-forwarder/
