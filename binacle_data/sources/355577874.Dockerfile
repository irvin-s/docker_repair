# FROM java:8
FROM java:8-jre

COPY entrypoint.sh /opt/entrypoint.sh

RUN mkdir /opt/jmx_prometheus_httpserver \
  && wget 'http://central.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_httpserver/0.6/jmx_prometheus_httpserver-0.6-jar-with-dependencies.jar' \
      -O /opt/jmx_prometheus_httpserver/jmx_prometheus_httpserver.jar \
  && curl -jkSL https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 -o /usr/local/bin/confd \
  && chmod +x /usr/local/bin/confd \
  && chmod +x /opt/entrypoint.sh

# http://central.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_httpserver/0.9/jmx_prometheus_httpserver-0.9-jar-with-dependencies.jar
# ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
COPY confd /etc/confd
# RUN chmod +x /usr/local/bin/confd

# COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]
