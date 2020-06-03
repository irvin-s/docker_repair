FROM ubuntu:vivid

ENV DEBIAN_FRONTEND noninteractive

# Usual update / upgrade
RUN apt-get update && apt-get upgrade -q -y && apt-get dist-upgrade -q -y

# Let our containers upgrade themselves
RUN apt-get install -q -y unattended-upgrades

# Install usual tools
RUN apt-get install -q -y wget vim

# Install Java... eurk
RUN apt-get install -q -y openjdk-7-jre-headless

# Install logstash
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/logstash/1.5/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch.list
RUN apt-get update && apt-get install -q -y logstash

# Add configs
ADD conf.d /etc/logstash/conf.d

# Add configurations
ADD conf/elasticsearch.yml /etc/logstash/elasticsearch.yml

# Add logstash-forwarder key and certificate
ADD conf/logstash-forwarder.key /etc/logstash/logstash-forwarder.key
ADD conf/logstash-forwarder.crt /etc/logstash/logstash-forwarder.crt

EXPOSE 5000

ENV JAVA_OPTS -Djava.io.tmpdir=/var/lib/logstash -Des.config=/etc/logstash/elasticsearch.yml

ENTRYPOINT ["/opt/logstash/bin/logstash", "-f", "/etc/logstash/conf.d"]
