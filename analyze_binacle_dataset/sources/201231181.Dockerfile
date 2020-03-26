FROM oneops/centos7

# elasticsearch
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
COPY elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
RUN yum -y install elasticsearch

RUN sed -i -- 's/\#cluster\.name\: elasticsearch/cluster\.name\: oneops/g' /etc/elasticsearch/elasticsearch.yml
RUN echo "export ES_HEAP_SIZE=512m" > /etc/profile.d/es.sh
COPY elasticsearch.sh /opt/elasticsearch.sh

COPY cms_template.json /var/cms_template.json
COPY event_template.json /var/event_template.json
COPY search.sh /opt/search.sh

COPY elasticsearch.ini /etc/supervisord.d/elasticsearch.ini
