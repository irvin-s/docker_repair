FROM java:8
ENV LOG_DELEGATE -Dvertx.logger-delegate-factory-class-name=io.vertx.core.logging.SLF4JLogDelegateFactory
ENV LOG_CONTEXT -DLog4jContextSelector=org.apache.logging.log4j.core.async.AsyncLoggerContextSelector

## vert.x options and system properties (-Dfoo=bar). 
ENV VERTX_OPTS $LOG_DELEGATE $LOG_CONTEXT

## Install Filebeat and prerequisites

RUN apt-get update -qq \
 && apt-get install -qqy curl \
 && apt-get clean

RUN curl -L -O https://download.elastic.co/beats/filebeat/filebeat_1.2.3_amd64.deb \
 && dpkg -i filebeat_1.2.3_amd64.deb \
 && rm filebeat_1.2.3_amd64.deb

## Add Filebeat configuration
ADD filebeat.yml /etc/filebeat/filebeat.yml

## Add CA certificate
RUN mkdir -p /etc/pki/tls/certs
ADD logstash-beats.crt /etc/pki/tls/certs/logstash-beats.crt

## Application
COPY ./target/vertx-elk-1.0-fat.jar /opt/
RUN chmod -R 777 /opt

## Add dashboards and script to load them
RUN mkdir -p /etc/kibana/dashboards
COPY dashboards /etc/kibana/dashboards
ADD ./loadDashboards.sh /tmp/loadDashboards.sh
RUN chmod +x /tmp/loadDashboards.sh

## Start script
ADD ./start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh
CMD [ "/tmp/start.sh" ]