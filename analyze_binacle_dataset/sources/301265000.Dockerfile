# DESCRIPTION:    Logstash
# SOURCE:         https://github.com/rootsongjc/docker-images/tree/master/logstash/logstash-5.3.0
FROM index.tenxcloud.com/jimmy/jdk:8u45
MAINTAINER Jimmy Song <rootsongjc@gmail.com>

# Install Logstash
RUN cd /usr/local && \
    curl -L -O "https://artifacts.elastic.co/downloads/logstash/logstash-5.3.0.tar.gz" && \
    tar xvf logstash-5.3.0.tar.gz && \
    rm -f logstash-5.3.0.tar.gz && \
    ln -s /usr/local/logstash-5.3.0 /usr/local/logstash && \
    mkdir -p /usr/local/logstash/agent/

ENV LOGSTASH_HOME /usr/local/logstash
ENV LogFile /var/log/yum.log
ENV ES_SERVER 172.21.14.5:9200
ENV INDICES xg-docker
ENV CODEC plain

ADD ./node.conf  /usr/local/logstash/agent/
ADD ./docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD $LOGSTASH_HOME/bin/logstash -f $LOGSTASH_HOME/agent/node.conf
