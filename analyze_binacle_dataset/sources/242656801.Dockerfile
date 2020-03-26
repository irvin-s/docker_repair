FROM debian:jessie

RUN apt-get update && \
    apt-get -y -q install curl && \
    curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.2.0-amd64.deb && \
    dpkg -i filebeat-5.2.0-amd64.deb && \
    mkdir /var/log/shared

COPY ./conf/filebeat.yml /etc/filebeat/filebeat.yml

ENTRYPOINT ["/usr/share/filebeat/bin/filebeat"]
CMD ["-path.config", "/etc/filebeat/"]