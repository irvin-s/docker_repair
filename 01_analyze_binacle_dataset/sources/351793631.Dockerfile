FROM index.alauda.cn/library/centos:6
#FROM docker.io/centos:6

RUN yum install -y wget tar

RUN cd /opt && \
wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.2-linux-x64.tar.gz && \
tar -xzvf ./kibana-4.0.2-linux-x64.tar.gz && \
mv kibana-4.0.2-linux-x64 kibana && \
rm kibana-4.0.2-linux-x64.tar.gz

ADD conf/kibana.yml /opt/kibana/config/kibana.yml
ADD run.sh /run.sh

EXPOSE 5601

ENTRYPOINT ["/run.sh"]
#ENTRYPOINT ["/opt/kibana/bin/kibana"]
