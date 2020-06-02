FROM java:openjdk-7u79-jre
MAINTAINER SequenceIQ

# Logstash 1.4.2

#Install repo keys
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -

#Install Logstash
RUN echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' | tee /etc/apt/sources.list.d/logstash.list
RUN apt-get update && apt-get install -y logstash=1.4.2-1-2c0f5a1

#Workaround regarding ulimit privileges
RUN sed -i.bak '/set ulimit as/,+2 s/^/#/' /etc/init.d/logstash
RUN sed -i.bak 's/args=\"/args=\"-verbose /' /etc/init.d/logstash
RUN sed -i.bak 's/LS_USER=logstash/LS_USER=root/' /etc/init.d/logstash

#Configure Logstash INPUT and FILTER
ADD	logstash/shipper/shipper-common.conf /etc/logstash/conf.d/shipper-common.conf
ADD	logstash/shipper/shipper-consul.conf /etc/logstash/conf.d/shipper-consul.conf
ADD	logstash/shipper/shipper-consul-watch.conf /etc/logstash/conf.d/shipper-consul-watch.conf
ADD	logstash/shipper/shipper-ambari-server.conf /etc/logstash/conf.d/shipper-ambari-server.conf
ADD	logstash/shipper/shipper-ambari-agent.conf /etc/logstash/conf.d/shipper-ambari-agent.conf
ADD	logstash/shipper/shipper-kerberos-kdc.conf /etc/logstash/conf.d/shipper-kerberos-kdc.conf

#Create sincedb directory
RUN mkdir /sincedb

#Configure Logstash PATTERN
RUN mkdir /etc/logstash/conf.d/patterns
ADD logstash/pattern/custom_patterns /etc/logstash/conf.d/patterns/custom_patterns

#Configure Logstash OUTPUT
ADD logstash/outputs/output.conf /etc/logstash/conf.d/output.conf

#Bootstrap file
ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh

ENTRYPOINT ["/etc/bootstrap.sh"]

CMD ["-d"]
