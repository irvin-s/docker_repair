FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
    golang \
    git \
    build-essential \
    ruby \
    wget && \
  git clone git://github.com/elasticsearch/logstash-forwarder.git && \
  cd logstash-forwarder && \
  go build -o logstash-forwarder && \
  gem install pleaserun && \
  make generate-init-script && \
  cp -r build/etc / && \
  mkdir /var/log/logstash-forwarder && \
  cp logstash-forwarder.conf.example /etc/logstash-forwarder.conf

RUN wget --no-check-certificate https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 && \
  chmod +x confd-0.7.1-linux-amd64 && \
  mv confd-0.7.1-linux-amd64 /usr/local/bin/confd && \
  mkdir -p /etc/confd/conf.d && mkdir -p /etc/confd/templates

ADD start.sh /start.sh
RUN chmod +x /start.sh
ADD lumberjack_ss.crt /logstash-forwarder/lumberjack_core.crt
ADD lumberjack_ss.key /logstash-forwarder/lumberjack_core.key


CMD /start.sh
