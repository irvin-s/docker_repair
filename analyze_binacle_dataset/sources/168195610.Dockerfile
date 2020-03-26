FROM xuwang/elasticsearch

USER root
ADD logstash.repo /etc/yum.repos.d/
RUN yum install -y logstash && mkdir -p /var/lib/logstash
ADD ./config /var/lib/logstash/config
VOLUME /var/lib/logstash/config
ENV PATH /opt/logstash/bin:$PATH
ADD run.sh /run.sh
USER logstash
CMD /run.sh

EXPOSE 5000
