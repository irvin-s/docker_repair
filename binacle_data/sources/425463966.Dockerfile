FROM devopsil/java

#
# 4.0.0 is in Beta so not available via repositories yet
#

RUN yum install -y tar \ 
      && yum install -y which \
      && curl -o /tmp/kibana-4.0.0-BETA1.1.tar.gz https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-BETA1.1.tar.gz \
      && mkdir -p /opt/kibana \
      && tar xzf /tmp/kibana-4.0.0-BETA1.1.tar.gz -C /opt/kibana

ENV JAVA_XMX        512m
# JAVA_OPTS for Kibana can be passed here
# ENV JAVA_OPTS       
ENV ELASTICSEARCH   http://elastic:9200

ADD kibana.sh   /opt/kibana/kibana-4.0.0-BETA1.1/bin/kibana.sh
ADD kibana.yml   /opt/kibana/kibana-4.0.0-BETA1.1/config/kibana.yml

EXPOSE 5601

ENTRYPOINT [ "/opt/kibana/kibana-4.0.0-BETA1.1/bin/kibana.sh" ]
