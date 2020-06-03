FROM index.alauda.cn/library/centos:6

RUN rpm -i https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.5.noarch.rpm

ADD conf/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

RUN mkdir -p /usr/share/elasticsearch/config && \
ln -s /etc/elasticsearch/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml && \
ln -s /etc/elasticsearch/logging.yml /usr/share/elasticsearch/config/logging.yml

RUN yum install -y java which

VOLUME ["/var/lib/elasticsearch"]

EXPOSE 9200

#ENTRYPOINT ["/bin/sh"]

ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]
