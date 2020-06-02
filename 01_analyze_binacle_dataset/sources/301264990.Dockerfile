# DESCRIPTION:    Filebeat
# SOURCE:         https://github.com/rootsongjc/docker-images/tree/master/filebeat/filebeat-5.4.0
FROM index.tenxcloud.com/jimmy/centos:7.2.1511
MAINTAINER Jimmy Song <rootsongjc@gmail.com>

# Install Filebeat
RUN cd /usr/local && \
    curl -L -O "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.4.0-linux-x86_64.tar.gz" && \
    tar xvf filebeat-5.4.0-linux-x86_64.tar.gz && \
    rm -f filebeat-5.4.0-linux-x86_64.tar.gz && \
    ln -s /usr/local/filebeat-5.4.0-linux-x86_64 /usr/local/filebeat && \
    chmod +x /usr/local/filebeat/filebeat && \
    mkdir -p /etc/filebeat

ENV PATHS /var/log/yum.log
ENV ES_SERVER 172.23.5.255:9200
ENV INDEX filebeat-test
ENV INPUT_TYPE log
ENV ES_USERNAME elastic
ENV ES_PASSWORD changeme

ADD ./filebeat.yml /etc/filebeat/
ADD ./docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/usr/local/filebeat/filebeat","-e","-c","/etc/filebeat/filebeat.yml"]
