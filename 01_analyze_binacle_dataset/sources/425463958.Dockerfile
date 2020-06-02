FROM devopsil/java

# elasticsearch.org/guide/en/elasticsearch/reference/current/setup-repositories.html
ADD elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
RUN rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch \
    && yum install -y elasticsearch-1.3.4 \
    && yum install -y which \
    && yum clean all

ENV CONF_DIR       /etc/elasticsearch
ENV CONF_FILE      /etc/elasticsearch/elasticsearch.yml
ENV DATA_DIR       /var/lib/elasticsearch
ENV ES_HOME        /usr/share/elasticsearch
ENV ES_USER        elasticsearch
ENV LOG_DIR        /var/log/elasticsearch
ENV MAX_OPEN_FILES 65535
ENV WORK_DIR       /tmp/elasticsearch

ADD elasticsearch.sh   /elasticsearch.sh

EXPOSE 9200 9300
VOLUME [ "/var/lib/elasticsearch", "/var/log/elasticsearch" ]

ENTRYPOINT [ "/elasticsearch.sh" ]
