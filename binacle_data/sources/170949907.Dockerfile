# Scribe

FROM      debian:sid

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# install deps
RUN apt-get install -y wget git golang ruby ruby-dev rubygems irb ri rdoc build-essential libssl-dev zlib1g-dev

# clone logstash-forwarder
RUN git clone git://github.com/elasticsearch/logstash-forwarder.git /tmp/logstash-forwarder
RUN cd /tmp/logstash-forwarder && go build && cp logstash-forwarder /opt

# Install fpm
RUN gem install fpm

# Cleanup
RUN rm -rf /tmp/*

ADD run.sh /usr/local/bin/run.sh
RUN chmod 755 /usr/local/bin/run.sh

RUN mkdir /opt/certs/
ADD certs/logstash-forwarder.crt /opt/certs/logstash-forwarder.crt
ADD certs/logstash-forwarder.key /opt/certs/logstash-forwarder.key

CMD /usr/local/bin/run.sh
