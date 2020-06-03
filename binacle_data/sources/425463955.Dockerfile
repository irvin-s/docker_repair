FROM devopsil/java

#
# 1.4.0 is in Beta so not available via repositories yet
#

## elasticsearch.org/guide/en/elasticsearch/reference/current/setup-repositories.html
# ADD elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
# RUN rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch \
#     && yum install -y elasticsearch-1.4.0 \
#     && yum install -y which \
#     && yum clean all

# 1.4.0beta shortcut rpm
RUN rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch \
    && rpm -Uh https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.0.Beta1.noarch.rpm \
    && yum install -y which && yum clean all

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
