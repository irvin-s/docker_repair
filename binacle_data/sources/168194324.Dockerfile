FROM mattdm/fedora-small:f20

ADD GPG-KEY-elasticsearch /etc/pki/rpm-gpg/
ADD elasticsearch.repo /etc/yum.repos.d/

# https://github.com/elasticsearch/logstash/pull/1707
RUN rpm --import /etc/pki/rpm-gpg/GPG-KEY-elasticsearch && \
	yum install -y "jre >= 1.6.0" "/usr/bin/which" elasticsearch

ADD ./run.sh /run.sh
RUN chmod a+x /run.sh

VOLUME /var/lib/elasticsearch
USER elasticsearch
CMD  ["/run.sh"]

# HTTP interface
EXPOSE 9200
# Cluster interface
EXPOSE 9300
