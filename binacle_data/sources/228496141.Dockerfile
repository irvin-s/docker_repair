FROM tomcat:7.0-jre7

ENV JMX_PROMETHEUS_HTTPSERVER_VERSION 0.7-SNAPSHOT

ENV CATALINA_OPTS "-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=8880 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.local.only=false"

RUN apt-get update && apt-get install -y curl supervisor

RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /jmx_prometheus_httpserver /jmx_prometheus

COPY tomcat.yml /jmx_prometheus/tomcat.yml

WORKDIR /jmx_prometheus_httpserver

RUN curl -O -k -L https://github.com/yagniio/docker-jmx-exporter/releases/download/$JMX_PROMETHEUS_HTTPSERVER_VERSION/jmx_prometheus_httpserver-$JMX_PROMETHEUS_HTTPSERVER_VERSION-jar-with-dependencies.jar

EXPOSE 8080 9138

CMD ["/usr/bin/supervisord"]
