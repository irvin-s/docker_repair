FROM mattdm/fedora-small:f20
MAINTAINER Tom Prince <tom.prince@clusterhq.com>

ADD GPG-KEY-elasticsearch /etc/pki/rpm-gpg/
ADD elasticsearch.repo /etc/yum.repos.d/
RUN ["rpm", "--import", "/etc/pki/rpm-gpg/GPG-KEY-elasticsearch"]
# https://github.com/elasticsearch/elasticsearch/pull/7598
RUN ["yum", "install", "-y", "jre >= 1.6.0", "/usr/bin/which"]
RUN ["yum", "install", "-y", "elasticsearch"]

VOLUME /var/lib/elasticsearch
USER elasticsearch
CMD  source /etc/sysconfig/elasticsearch; /usr/share/elasticsearch/bin/elasticsearch -p /var/run/elasticsearch/elasticsearch.pid -Des.default.config=$CONF_FILE -Des.default.path.home=$ES_HOME -Des.default.path.logs=$LOG_DIR -Des.default.path.data=$DATA_DIR -Des.default.path.work=$WORK_DIR -Des.default.path.conf=$CONF_DIR

# HTTP interface
EXPOSE 9200
# Cluster interface
EXPOSE 9300
