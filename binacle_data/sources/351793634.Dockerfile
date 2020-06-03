FROM index.alauda.cn/library/centos:6

RUN yum install -y java which

RUN rpm -i https://download.elasticsearch.org/logstash/logstash/packages/centos/logstash-1.4.2-1_2c0f5a1.noarch.rpm

ADD conf/logstash.conf /etc/logstash/conf.d/logstash.conf
ADD conf/elasticsearch.yml /etc/logstash/elasticsearch.yml

EXPOSE 5000

ENV JAVA_OPTS -Djava.io.tmpdir=/var/lib/logstash

ADD run.sh /run.sh

ENTRYPOINT ["/run.sh"]

#ENTRYPOINT ["/opt/logstash/bin/logstash", "-f" , "/etc/logstash/conf.d/logstash.conf"]
