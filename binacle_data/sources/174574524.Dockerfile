FROM ubuntu:vivid
MAINTAINER caktux

ENV DEBIAN_FRONTEND noninteractive

# Usual update / upgrade
RUN apt-get update
RUN apt-get upgrade -q -y
RUN apt-get dist-upgrade -q -y

# Install useful tools
RUN apt-get install -q -y wget vim git

# Install logstash-forwarder
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/logstashforwarder/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch.list
RUN apt-get update
RUN apt-get install -q -y logstash-forwarder

# Add certificate and key
ADD logstash-forwarder.crt /etc/logstash/logstash-forwarder.crt
ADD logstash-forwarder.key /etc/logstash/logstash-forwarder.key

# Add configs
ADD logstash-forwarder.conf /etc/logstash-forwarder.conf

CMD ["-config", "/etc/logstash-forwarder.conf"]
ENTRYPOINT ["/opt/logstash-forwarder/bin/logstash-forwarder"]
